using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;
using Unity.Collections;

namespace Sekia
{
    /// <summary>
    /// 根据配置支持延迟-前向-UI等渲染
    /// </summary>
    public sealed class SekiaRenderer : IDisposable
    {
        /*渲染实时设置的意义
            CameraType.Game 通常实时相机 或 选中相机时在Scene界面右下角出现的Game预览
            CameraType.SceneView 渲染Scene界面
            CameraType.Preview 材质预览 相机预览
            CameraType.Reflection 反射探针

            1 是否需要中间颜色RT
                能不能直接渲染到backBuffer或targetRenderTexture => 能 但有诸多功能限制
                    => 显示器的backBuffer同时包含了颜色和深度 不便于分离
                    => 使用中间RT合成多个相机的效果 这对于非栈模式的多个独立相机并不是强制要求
                    => 延迟渲染需要中间RT Gbuffer pass深度RT不执行Y反转 但是Deferred pass对颜色和深度buffer要执行Y反转
                    => SceneView相机需要中间RT SceneView相机的目标RT需要输入深度值 用于debug渲染
                    => Preview相机不需要中间RT 相当于极简模式 唯一明确不需要中间颜色RT的情况
                    => 需要CopyColor时 
                    => 需要后处理时(或者录屏) 可能极简情况下可关闭后处理/CopyColor
                    => 非默认视口时 根据视口偏移Blit到目标RT
                    => 渲染精度放大或缩小 RT分辨率自定义 需要Blit
                    => HDR开启时 RT格式自定义 需要Blit
                    => 目标显示器backBuffer不支持自动的sRGB转换 需要用户手动将Linear转换为Gamma

            2 是否需要中间深度RT
                深度RT用于Copy、深度测试减少OverDraw等 不管是预计算深度还是逐DrawCall累积深度都可以确定要深度RT
                深度RT可以创建中间深度RT或直接使用backBuffer的深度Buffer
                    => 如果没预计算深度 又需要copy 那么数据来源肯定是中间深度RT
                    => NativeRenderPass + 延迟渲染可以省略中间深度RT
                    => //Scene filtering redraws the objects on top of the resulting frame. It has to draw directly to the sceneview buffer.
                        => camera.sceneViewFilterMode == Camera.SceneViewFilterMode.ShowFiltered;

            3 是否需要CopyDepth
                CopyDepth RT经常用于重建世界坐标 在特效中使用
                因为要同时进行深度读和深度写操作 所以需要除了深度目标以外的深度RT作为采样源
                如果确实有需要可以在渲染不透明物体后Copy一次深度
                延迟渲染+NativeRenderPass可以省略CopyDepth
                    如果延迟渲染没有开启NativeRenderPass => 退回到Forwar+
                Depth RT格式问题：如果RT需要作为深度目标被写入 则format需要为Depth 其他情况则为单通道浮点数
                默认值：Shader.SetGlobalTexture("_CameraDepthTexture", SystemInfo.usesReversedZBuffer ? Texture2D.blackTexture : Texture2D.whiteTexture);

            4 是否需要预计算深度(DepthOnly Pass)
                需要用到CopyDepth RT 但是无法通过采样深度buffer复制深度值 如GLES平台复制深度值有性能问题
                开启了MSAA时且硬件不支持MSAA Resolve时
                预计算深度是需要避免的 应充分利用EarlyZ减少OverDraw
                SceneView/Preview/Gizmos等模式下不需要考虑性能
                延迟渲染下无需预计算深度

            5 DepthNormal prepass在什么情况下渲染:
                延迟渲染下：在Gbuffer Pass之后为ForwardOnly物体执行DepthNormal prepass补充深度值和法线值
                前向渲染下：渲染全部几何体生成深度Buffer和Normal Buffer

            6 NativeRenderPass在什么情况下关闭
                NativeRenderPass用于移动端延迟渲染
                https://community.arm.com/arm-community-blogs/b/graphics-gaming-and-vr-blog/posts/deferred-shading-on-mobile
                    Write GBuffer (albedo, normal, pbr, depth) => on-chip
                    Read GBuffer                               => on-chip
                    Write Color/Depth                          => Flush to memory
                利用Tile内存/MRT/FrameBuffer Fetch 让GBuffer的写和读都发生在on-chip 不消耗额外的带宽
                    
                延迟渲染下：GBuffer pass和Deferred pass应该是一个连续Pass(合并)
                    SSAO：在Deferred pass中需要采样由SSAO产生的AO遮罩 基于随机采样深度获得近似AO
                        GBuffer pass → SSAO(不是基于Tiled) → Deferred pass这样会打断NativeRenderPass
                        改进：SSAO (depth previous frame) → [GBuffer → Lighting]
                保持像素数据在Tile内存 不Flush to memory
                GBuffer布局限制在128bit
                    Gbuffer布局：

            7 ShadowMap的生成
                主阴影和额外阴影如果初始化判断失败也会分别生成1x1的默认ShadowMap
                可以设置透明pass是否采样阴影 但是没必要 比如半透明的布或草

            8 渲染目标store操作优化
                如果放弃保存对渲染目标的写入信息可以节约带宽 比如后面不需要深度RT时放弃保存深度
            */

        #region 来自父级的属性1



        /// <summary>
        /// Set the Camera billboard properties.
        /// </summary>
        /// <param name="cmd">CommandBuffer to submit data to GPU.</param>
        /// <param name="cameraData">CameraData containing camera matrices information.</param>
        public void SetPerCameraBillboardProperties(CommandBuffer cmd, ref CameraData cameraData)
        {
            Matrix4x4 worldToCameraMatrix = cameraData.GetViewMatrix();
            Vector3 cameraPos = cameraData.worldSpaceCameraPos;

            CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.BillboardFaceCameraPos, QualitySettings.billboardsFaceCameraPosition);

            Vector3 billboardTangent;
            Vector3 billboardNormal;
            float cameraXZAngle;
            CalculateBillboardProperties(worldToCameraMatrix, out billboardTangent, out billboardNormal, out cameraXZAngle);

            cmd.SetGlobalVector(ShaderPropertyId.billboardNormal, new Vector4(billboardNormal.x, billboardNormal.y, billboardNormal.z, 0.0f));
            cmd.SetGlobalVector(ShaderPropertyId.billboardTangent, new Vector4(billboardTangent.x, billboardTangent.y, billboardTangent.z, 0.0f));
            cmd.SetGlobalVector(ShaderPropertyId.billboardCameraParams, new Vector4(cameraPos.x, cameraPos.y, cameraPos.z, cameraXZAngle));
        }

        private static void CalculateBillboardProperties(
            in Matrix4x4 worldToCameraMatrix,
            out Vector3 billboardTangent,
            out Vector3 billboardNormal,
            out float cameraXZAngle)
        {
            Matrix4x4 cameraToWorldMatrix = worldToCameraMatrix;
            cameraToWorldMatrix = cameraToWorldMatrix.transpose;

            Vector3 cameraToWorldMatrixAxisX = new Vector3(cameraToWorldMatrix.m00, cameraToWorldMatrix.m10, cameraToWorldMatrix.m20);
            Vector3 cameraToWorldMatrixAxisY = new Vector3(cameraToWorldMatrix.m01, cameraToWorldMatrix.m11, cameraToWorldMatrix.m21);
            Vector3 cameraToWorldMatrixAxisZ = new Vector3(cameraToWorldMatrix.m02, cameraToWorldMatrix.m12, cameraToWorldMatrix.m22);

            Vector3 front = cameraToWorldMatrixAxisZ;

            Vector3 worldUp = Vector3.up;
            Vector3 cross = Vector3.Cross(front, worldUp);
            billboardTangent = !Mathf.Approximately(cross.sqrMagnitude, 0.0f)
                ? cross.normalized
                : cameraToWorldMatrixAxisX;

            billboardNormal = Vector3.Cross(worldUp, billboardTangent);
            billboardNormal = !Mathf.Approximately(billboardNormal.sqrMagnitude, 0.0f)
                ? billboardNormal.normalized
                : cameraToWorldMatrixAxisY;

            // SpeedTree generates billboards starting from looking towards X- and rotates counter clock-wisely
            Vector3 worldRight = new Vector3(0, 0, 1);
            // signed angle is calculated on X-Z plane
            float s = worldRight.x * billboardTangent.z - worldRight.z * billboardTangent.x;
            float c = worldRight.x * billboardTangent.x + worldRight.z * billboardTangent.z;
            cameraXZAngle = Mathf.Atan2(s, c);

            // convert to [0,2PI)
            if (cameraXZAngle < 0)
                cameraXZAngle += 2 * Mathf.PI;
        }

        public void SetPerCameraClippingPlaneProperties(CommandBuffer cmd, ref CameraData cameraData)
        {
            SetPerCameraClippingPlaneProperties(cmd, in cameraData, cameraData.IsCameraProjectionMatrixFlipped());
        }

        private void SetPerCameraClippingPlaneProperties(CommandBuffer cmd, in CameraData cameraData, bool isTargetFlipped)
        {
            Matrix4x4 projectionMatrix = cameraData.GetGPUProjectionMatrix(isTargetFlipped);
            Matrix4x4 viewMatrix = cameraData.GetViewMatrix();

            Matrix4x4 viewProj = CoreMatrixUtils.MultiplyProjectionMatrix(projectionMatrix, viewMatrix, cameraData.camera.orthographic);
            Plane[] planes = s_Planes;
            GeometryUtility.CalculateFrustumPlanes(viewProj, planes);

            Vector4[] cameraWorldClipPlanes = s_VectorPlanes;
            for (int i = 0; i < planes.Length; ++i)
                cameraWorldClipPlanes[i] = new Vector4(planes[i].normal.x, planes[i].normal.y, planes[i].normal.z, planes[i].distance);

            cmd.SetGlobalVectorArray(ShaderPropertyId.cameraWorldClipPlanes, cameraWorldClipPlanes);
        }

        public RTHandle cameraColorTargetHandle
        {
            get
            {
                return m_CameraColorTarget.handle;
            }
        }

        public RTHandle cameraDepthTargetHandle
        {
            get
            {
                return m_CameraDepthTarget.handle;
            }
        }

        /// <summary>
        /// List of unsupported Graphics APIs for this renderer.
        /// <see cref="unsupportedGraphicsDeviceTypes"/>
        /// </summary>
        public GraphicsDeviceType[] unsupportedGraphicsDeviceTypes { get; set; } = new GraphicsDeviceType[0];

        static class RenderPassBlock
        {
            // Executes render passes that are inputs to the main rendering
            // but don't depend on camera state. They all render in monoscopic mode. f.ex, shadow maps.
            public static readonly int BeforeRendering = 0;

            // Main bulk of render pass execution. They required camera state to be properly set
            // and when enabled they will render in stereo.
            public static readonly int MainRenderingOpaque = 1;
            public static readonly int MainRenderingTransparent = 2;

            // Execute after Post-processing.
            public static readonly int AfterRendering = 3;
        }

        public StoreActionsOptimization m_StoreActionsOptimizationSetting = StoreActionsOptimization.Auto;
        public static bool m_UseOptimizedStoreActions = false;

        const int k_RenderPassBlockCount = 4;

        public List<SekiaRendererPass> m_ActiveRenderPassQueue = new List<SekiaRendererPass>(32);
        public List<SekiaRendererFeature> m_RendererFeatures = new List<SekiaRendererFeature>(10);

        // Compatibility to support setting targets with RenderTargetIdentifier or RTHandle
        // to be removed once setting RenderTargetIdentifier as target is removed
        internal struct RTHandleRenderTargetIdentifierCompat
        {
            public RTHandle handle;
            public RenderTargetIdentifier fallback;
            public bool useRTHandle => handle != null;
            public RenderTargetIdentifier nameID => useRTHandle ? new RenderTargetIdentifier(handle.nameID, 0, CubemapFace.Unknown, -1) : fallback;
        }

        internal RTHandleRenderTargetIdentifierCompat m_CameraColorTarget;
        internal RTHandleRenderTargetIdentifierCompat m_CameraDepthTarget;
        RTHandleRenderTargetIdentifierCompat m_CameraResolveTarget;

        public bool m_FirstTimeCameraColorTargetIsBound = true; // flag used to track when m_CameraColorTarget should be cleared (if necessary), as well as other special actions only performed the first time m_CameraColorTarget is bound as a render target
        public bool m_FirstTimeCameraDepthTargetIsBound = true; // flag used to track when m_CameraDepthTarget should be cleared (if necessary), the first time m_CameraDepthTarget is bound as a render target

        // The pipeline can only guarantee the camera target texture are valid when the pipeline is executing.
        // Trying to access the camera target before or after might be that the pipeline texture have already been disposed.
        bool m_IsPipelineExecuting = false;

        internal bool useRenderPassEnabled = false;
        public static RenderTargetIdentifier[] m_ActiveColorAttachments = new RenderTargetIdentifier[] { 0, 0, 0, 0, 0, 0, 0, 0 };
        public static RenderTargetIdentifier m_ActiveDepthAttachment;

        public static RenderBufferStoreAction[] m_ActiveColorStoreActions = new RenderBufferStoreAction[]
        {
            RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store,
            RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store
        };

        public static RenderBufferStoreAction m_ActiveDepthStoreAction = RenderBufferStoreAction.Store;

        // CommandBuffer.SetRenderTarget(RenderTargetIdentifier[] colors, RenderTargetIdentifier depth, int mipLevel, CubemapFace cubemapFace, int depthSlice);
        // called from CoreUtils.SetRenderTarget will issue a warning assert from native c++ side if "colors" array contains some invalid RTIDs.
        // To avoid that warning assert we trim the RenderTargetIdentifier[] arrays we pass to CoreUtils.SetRenderTarget.
        // To avoid re-allocating a new array every time we do that, we re-use one of these arrays:
        public static RenderTargetIdentifier[][] m_TrimmedColorAttachmentCopies = new RenderTargetIdentifier[][]
        {
            new RenderTargetIdentifier[0],                          // m_TrimmedColorAttachmentCopies[0] is an array of 0 RenderTargetIdentifier - only used to make indexing code easier to read
            new RenderTargetIdentifier[] {0},                        // m_TrimmedColorAttachmentCopies[1] is an array of 1 RenderTargetIdentifier
            new RenderTargetIdentifier[] {0, 0},                     // m_TrimmedColorAttachmentCopies[2] is an array of 2 RenderTargetIdentifiers
            new RenderTargetIdentifier[] {0, 0, 0},                  // m_TrimmedColorAttachmentCopies[3] is an array of 3 RenderTargetIdentifiers
            new RenderTargetIdentifier[] {0, 0, 0, 0},               // m_TrimmedColorAttachmentCopies[4] is an array of 4 RenderTargetIdentifiers
            new RenderTargetIdentifier[] {0, 0, 0, 0, 0},            // m_TrimmedColorAttachmentCopies[5] is an array of 5 RenderTargetIdentifiers
            new RenderTargetIdentifier[] {0, 0, 0, 0, 0, 0},         // m_TrimmedColorAttachmentCopies[6] is an array of 6 RenderTargetIdentifiers
            new RenderTargetIdentifier[] {0, 0, 0, 0, 0, 0, 0},      // m_TrimmedColorAttachmentCopies[7] is an array of 7 RenderTargetIdentifiers
            new RenderTargetIdentifier[] {0, 0, 0, 0, 0, 0, 0, 0 },  // m_TrimmedColorAttachmentCopies[8] is an array of 8 RenderTargetIdentifiers
        };

        private static Plane[] s_Planes = new Plane[6];
        private static Vector4[] s_VectorPlanes = new Vector4[6];

        internal static void ConfigureActiveTarget(RenderTargetIdentifier colorAttachment,
            RenderTargetIdentifier depthAttachment)
        {
            m_ActiveColorAttachments[0] = colorAttachment;
            for (int i = 1; i < m_ActiveColorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = 0;

            m_ActiveDepthAttachment = depthAttachment;
        }

        internal bool useDepthPriming { get; set; } = false;

        internal bool stripShadowsOffVariants { get; set; } = false;

        internal bool stripAdditionalLightOffVariants { get; set; } = false;

        public void Dispose()
        {
            // Dispose all renderer features...
            for (int i = 0; i < m_RendererFeatures.Count; ++i)
            {
                if (m_RendererFeatures[i] == null)
                    continue;

                m_RendererFeatures[i].Dispose();
            }

            GC.SuppressFinalize(this);
        }

        public void ConfigureCameraTarget(RTHandle colorTarget, RTHandle depthTarget)
        {
            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { handle = colorTarget };
            m_CameraDepthTarget = new RTHandleRenderTargetIdentifierCompat { handle = depthTarget };
        }

        internal void ConfigureCameraTarget(RTHandle colorTarget, RTHandle depthTarget, RTHandle resolveTarget)
        {
            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { handle = colorTarget };
            m_CameraDepthTarget = new RTHandleRenderTargetIdentifierCompat { handle = depthTarget };
            m_CameraResolveTarget = new RTHandleRenderTargetIdentifierCompat { handle = resolveTarget };
        }

        // This should be removed when early camera color target assignment is removed.
        internal void ConfigureCameraColorTarget(RTHandle colorTarget)
        {
            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { handle = colorTarget };
        }

        public bool IsRenderPassEnabled(SekiaRendererPass renderPass)
        {
            return renderPass.useNativeRenderPass && renderPass.m_UsesRTHandles && useRenderPassEnabled;
        }

        internal static void SetRenderTarget(CommandBuffer cmd, RTHandle colorAttachment, RTHandle depthAttachment, ClearFlag clearFlag, Color clearColor)
        {
            m_ActiveColorAttachments[0] = colorAttachment;
            for (int i = 1; i < m_ActiveColorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = 0;

            m_ActiveColorStoreActions[0] = RenderBufferStoreAction.Store;
            m_ActiveDepthStoreAction = RenderBufferStoreAction.Store;
            for (int i = 1; i < m_ActiveColorStoreActions.Length; ++i)
                m_ActiveColorStoreActions[i] = RenderBufferStoreAction.Store;

            m_ActiveDepthAttachment = depthAttachment;

            RenderBufferLoadAction colorLoadAction = ((uint)clearFlag & (uint)ClearFlag.Color) != 0 ? RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;

            RenderBufferLoadAction depthLoadAction = ((uint)clearFlag & (uint)ClearFlag.Depth) != 0 || ((uint)clearFlag & (uint)ClearFlag.Stencil) != 0 ?
                RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;

            // Storing depth and color in the same RT should only be possible with alias RTHandles, those that create rendertargets with RTAlloc()
            if (colorAttachment.rt == null && depthAttachment.rt == null && depthAttachment.nameID == GlobalData.Instance.k_CameraTarget.nameID)
                CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, RenderBufferStoreAction.Store,
                    depthLoadAction, RenderBufferStoreAction.Store, clearFlag, clearColor);
            else
                SetRenderTarget(cmd, colorAttachment, colorLoadAction, RenderBufferStoreAction.Store,
                    depthAttachment, depthLoadAction, RenderBufferStoreAction.Store, clearFlag, clearColor);
        }

        internal static void SetRenderTarget(CommandBuffer cmd, RTHandle colorAttachment, RTHandle depthAttachment, ClearFlag clearFlag, Color clearColor, RenderBufferStoreAction colorStoreAction, RenderBufferStoreAction depthStoreAction)
        {
            m_ActiveColorAttachments[0] = colorAttachment;
            for (int i = 1; i < m_ActiveColorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = 0;

            m_ActiveColorStoreActions[0] = colorStoreAction;
            m_ActiveDepthStoreAction = depthStoreAction;
            for (int i = 1; i < m_ActiveColorStoreActions.Length; ++i)
                m_ActiveColorStoreActions[i] = RenderBufferStoreAction.Store;

            m_ActiveDepthAttachment = depthAttachment;

            RenderBufferLoadAction colorLoadAction = ((uint)clearFlag & (uint)ClearFlag.Color) != 0 ?
                RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;

            RenderBufferLoadAction depthLoadAction = ((uint)clearFlag & (uint)ClearFlag.Depth) != 0 ?
                RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;

            // if we shouldn't use optimized store actions then fall back to the conservative safe (un-optimal!) route and just store everything
            if (!m_UseOptimizedStoreActions)
            {
                if (colorStoreAction != RenderBufferStoreAction.StoreAndResolve)
                    colorStoreAction = RenderBufferStoreAction.Store;
                if (depthStoreAction != RenderBufferStoreAction.StoreAndResolve)
                    depthStoreAction = RenderBufferStoreAction.Store;
            }


            SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction,
                depthAttachment, depthLoadAction, depthStoreAction, clearFlag, clearColor);
        }

        static void SetRenderTarget(CommandBuffer cmd,
            RTHandle colorAttachment,
            RenderBufferLoadAction colorLoadAction,
            RenderBufferStoreAction colorStoreAction,
            ClearFlag clearFlags,
            Color clearColor)
        {
            CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction, clearFlags, clearColor);
        }

        static void SetRenderTarget(CommandBuffer cmd,
            RTHandle colorAttachment,
            RenderBufferLoadAction colorLoadAction,
            RenderBufferStoreAction colorStoreAction,
            RTHandle depthAttachment,
            RenderBufferLoadAction depthLoadAction,
            RenderBufferStoreAction depthStoreAction,
            ClearFlag clearFlags,
            Color clearColor)
        {
            CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction,
                depthAttachment, depthLoadAction, depthStoreAction, clearFlags, clearColor);
        }

        static void SetRenderTarget(CommandBuffer cmd, RTHandle[] colorAttachments, RTHandle depthAttachment, ClearFlag clearFlag, Color clearColor)
        {
            if (m_ActiveColorAttachments.Length != colorAttachments.Length)
                m_ActiveColorAttachments = new RenderTargetIdentifier[colorAttachments.Length];

            for (int i = 0; i < colorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = colorAttachments[i].nameID;
            m_ActiveDepthAttachment = depthAttachment.nameID;

            CoreUtils.SetRenderTarget(cmd, m_ActiveColorAttachments, depthAttachment, clearFlag, clearColor);
        }

        [System.Diagnostics.Conditional("UNITY_EDITOR")]
        public void DrawGizmos(ScriptableRenderContext context, Camera camera, GizmoSubset gizmoSubset, ref RenderingData renderingData)
        {
#if UNITY_EDITOR
            if (!UnityEditor.Handles.ShouldRenderGizmos() || camera.sceneViewFilterMode == Camera.SceneViewFilterMode.ShowFiltered)
                return;

            var cmd = renderingData.commandBuffer;
            using (new ProfilingScope(cmd, GlobalData.Profiling.drawGizmos))
            {
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                context.DrawGizmos(camera, gizmoSubset);
            }

            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
#endif
        }

        [System.Diagnostics.Conditional("UNITY_EDITOR")]
        public void DrawWireOverlay(ScriptableRenderContext context, Camera camera)
        {
#if UNITY_EDITOR
            context.DrawWireOverlay(camera);
#endif
        }
        #endregion



        #region 关于NativeRenderPass的属性
        private const int kRenderPassMapSize = 10;
        private const int kRenderPassMaxCount = 20;

        // used to keep track of the index of the last pass when we called BeginSubpass
        private int m_LastBeginSubpassPassIndex = 0;

        public Dictionary<Hash128, int[]> m_MergeableRenderPassesMap = new Dictionary<Hash128, int[]>(kRenderPassMapSize);
        // static array storing all the mergeableRenderPassesMap arrays. This is used to remove any GC allocs during the frame which would have been introduced by using a dynamic array to store the mergeablePasses per RenderPass
        public int[][] m_MergeableRenderPassesMapArrays;
        public Hash128[] m_PassIndexToPassHash = new Hash128[kRenderPassMaxCount];
        public Dictionary<Hash128, int> m_RenderPassesAttachmentCount = new Dictionary<Hash128, int>(kRenderPassMapSize);

        AttachmentDescriptor[] m_ActiveColorAttachmentDescriptors = new AttachmentDescriptor[]
        {
            RenderingUtils.emptyAttachment, RenderingUtils.emptyAttachment, RenderingUtils.emptyAttachment,
            RenderingUtils.emptyAttachment, RenderingUtils.emptyAttachment, RenderingUtils.emptyAttachment,
            RenderingUtils.emptyAttachment, RenderingUtils.emptyAttachment
        };
        AttachmentDescriptor m_ActiveDepthAttachmentDescriptor;

        bool[] m_IsActiveColorAttachmentTransient = new bool[]
        {
            false, false, false, false, false, false, false, false
        };

        internal RenderBufferStoreAction[] m_FinalColorStoreAction = new RenderBufferStoreAction[]
        {
            RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store,
            RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store
        };
        internal RenderBufferStoreAction m_FinalDepthStoreAction = RenderBufferStoreAction.Store;

        private static partial class Profiling
        {
            public static readonly ProfilingSampler setMRTAttachmentsList = new ProfilingSampler($"NativeRenderPass {nameof(SetNativeRenderPassMRTAttachmentList)}");
            public static readonly ProfilingSampler setAttachmentList = new ProfilingSampler($"NativeRenderPass {nameof(SetNativeRenderPassAttachmentList)}");
            public static readonly ProfilingSampler execute = new ProfilingSampler($"NativeRenderPass {nameof(ExecuteNativeRenderPass)}");
            public static readonly ProfilingSampler setupFrameData = new ProfilingSampler($"NativeRenderPass {nameof(SetupNativeRenderPassFrameData)}");
        }

        internal struct RenderPassDescriptor
        {
            internal int w, h, samples, depthID;

            internal RenderPassDescriptor(int width, int height, int sampleCount, int rtID)
            {
                w = width;
                h = height;
                samples = sampleCount;
                depthID = rtID;
            }
        }

        internal void ResetNativeRenderPassFrameData()
        {
            if (m_MergeableRenderPassesMapArrays == null)
                m_MergeableRenderPassesMapArrays = new int[kRenderPassMapSize][];

            for (int i = 0; i < kRenderPassMapSize; ++i)
            {
                if (m_MergeableRenderPassesMapArrays[i] == null)
                    m_MergeableRenderPassesMapArrays[i] = new int[kRenderPassMaxCount];

                for (int j = 0; j < kRenderPassMaxCount; ++j)
                {
                    m_MergeableRenderPassesMapArrays[i][j] = -1;
                }
            }
        }

        internal void SetupNativeRenderPassFrameData(ref CameraData cameraData, bool isRenderPassEnabled)
        {
            //TODO: edge cases to detect that should affect possible passes to merge
            // - total number of color attachment > 8

            // Go through all the passes and mark the final one as last pass

            using (new ProfilingScope(null, Profiling.setupFrameData))
            {
                int lastPassIndex = m_ActiveRenderPassQueue.Count - 1;

                // Make sure the list is already sorted!

                m_MergeableRenderPassesMap.Clear();
                m_RenderPassesAttachmentCount.Clear();
                uint currentHashIndex = 0;
                // reset all the passes last pass flag
                for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                {
                    var renderPass = m_ActiveRenderPassQueue[i];

                    renderPass.renderPassQueueIndex = i;

                    bool RPEnabled = IsRenderPassEnabled(renderPass);
                    if (!RPEnabled)
                        continue;

                    var rpDesc = InitializeRenderPassDescriptor(ref cameraData, renderPass);

                    Hash128 hash = CreateRenderPassHash(rpDesc, currentHashIndex);

                    m_PassIndexToPassHash[i] = hash;

                    if (!m_MergeableRenderPassesMap.ContainsKey(hash))
                    {
                        m_MergeableRenderPassesMap.Add(hash, m_MergeableRenderPassesMapArrays[m_MergeableRenderPassesMap.Count]);
                        m_RenderPassesAttachmentCount.Add(hash, 0);
                    }
                    else if (m_MergeableRenderPassesMap[hash][GetValidPassIndexCount(m_MergeableRenderPassesMap[hash]) - 1] != (i - 1))
                    {
                        // if the passes are not sequential we want to split the current mergeable passes list. So we increment the hashIndex and update the hash

                        currentHashIndex++;
                        hash = CreateRenderPassHash(rpDesc, currentHashIndex);

                        m_PassIndexToPassHash[i] = hash;

                        m_MergeableRenderPassesMap.Add(hash, m_MergeableRenderPassesMapArrays[m_MergeableRenderPassesMap.Count]);
                        m_RenderPassesAttachmentCount.Add(hash, 0);
                    }

                    m_MergeableRenderPassesMap[hash][GetValidPassIndexCount(m_MergeableRenderPassesMap[hash])] = i;
                }

                for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                {
                    m_ActiveRenderPassQueue[i].m_ColorAttachmentIndices = new NativeArray<int>(8, Allocator.Temp);
                    m_ActiveRenderPassQueue[i].m_InputAttachmentIndices = new NativeArray<int>(8, Allocator.Temp);
                }
            }
        }

        internal void UpdateFinalStoreActions(int[] currentMergeablePasses, ref CameraData cameraData)
        {
            for (int i = 0; i < m_FinalColorStoreAction.Length; ++i)
                m_FinalColorStoreAction[i] = RenderBufferStoreAction.Store;
            m_FinalDepthStoreAction = RenderBufferStoreAction.Store;

            foreach (var passIdx in currentMergeablePasses)
            {
                if (!m_UseOptimizedStoreActions)
                    break;

                if (passIdx == -1)
                    break;

                SekiaRendererPass pass = m_ActiveRenderPassQueue[passIdx];

                var samples = pass.overrideCameraTarget ? GetFirstAllocatedRTHandle(pass).rt.descriptor.msaaSamples :
                    (cameraData.targetTexture != null ? cameraData.targetTexture.descriptor.msaaSamples : cameraData.cameraTargetDescriptor.msaaSamples);

                // only override existing non destructive actions
                for (int i = 0; i < m_FinalColorStoreAction.Length; ++i)
                {
                    if (m_FinalColorStoreAction[i] == RenderBufferStoreAction.Store || m_FinalColorStoreAction[i] == RenderBufferStoreAction.StoreAndResolve || pass.overriddenColorStoreActions[i])
                        m_FinalColorStoreAction[i] = pass.colorStoreActions[i];

                    if (samples > 1)
                    {
                        if (m_FinalColorStoreAction[i] == RenderBufferStoreAction.Store)
                            m_FinalColorStoreAction[i] = RenderBufferStoreAction.StoreAndResolve;
                        else if (m_FinalColorStoreAction[i] == RenderBufferStoreAction.DontCare)
                            m_FinalColorStoreAction[i] = RenderBufferStoreAction.Resolve;
                    }
                }

                // only override existing store
                if (m_FinalDepthStoreAction == RenderBufferStoreAction.Store || (m_FinalDepthStoreAction == RenderBufferStoreAction.StoreAndResolve && pass.depthStoreAction == RenderBufferStoreAction.Resolve) || pass.overriddenDepthStoreAction)
                    m_FinalDepthStoreAction = pass.depthStoreAction;
            }
        }

        internal void SetNativeRenderPassMRTAttachmentList(SekiaRendererPass renderPass, ref CameraData cameraData, bool needCustomCameraColorClear, ClearFlag cameraClearFlag)
        {
            using (new ProfilingScope(null, Profiling.setMRTAttachmentsList))
            {
                int currentPassIndex = renderPass.renderPassQueueIndex;
                Hash128 currentPassHash = m_PassIndexToPassHash[currentPassIndex];
                int[] currentMergeablePasses = m_MergeableRenderPassesMap[currentPassHash];

                // Not the first pass
                if (currentMergeablePasses.First() != currentPassIndex)
                    return;

                m_RenderPassesAttachmentCount[currentPassHash] = 0;

                UpdateFinalStoreActions(currentMergeablePasses, ref cameraData);

                int currentAttachmentIdx = 0;
                bool hasInput = false;
                foreach (var passIdx in currentMergeablePasses)
                {
                    if (passIdx == -1)
                        break;
                    SekiaRendererPass pass = m_ActiveRenderPassQueue[passIdx];

                    for (int i = 0; i < pass.m_ColorAttachmentIndices.Length; ++i)
                        pass.m_ColorAttachmentIndices[i] = -1;

                    for (int i = 0; i < pass.m_InputAttachmentIndices.Length; ++i)
                        pass.m_InputAttachmentIndices[i] = -1;

                    uint validColorBuffersCount = RenderingUtils.GetValidColorBufferCount(pass.colorAttachmentHandles);

                    for (int i = 0; i < validColorBuffersCount; ++i)
                    {
                        AttachmentDescriptor currentAttachmentDescriptor =
                            new AttachmentDescriptor(pass.renderTargetFormat[i] != GraphicsFormat.None ? pass.renderTargetFormat[i] : UniversalRenderPipeline.MakeRenderTextureGraphicsFormat(cameraData.isHdrEnabled, cameraData.hdrColorBufferPrecision, Graphics.preserveFramebufferAlpha));

                        var colorHandle = pass.overrideCameraTarget ? pass.colorAttachmentHandles[i] : m_CameraColorTarget.handle;

                        int existingAttachmentIndex = FindAttachmentDescriptorIndexInList(colorHandle.nameID, m_ActiveColorAttachmentDescriptors);

                        if (m_UseOptimizedStoreActions)
                            currentAttachmentDescriptor.storeAction = m_FinalColorStoreAction[i];

                        if (existingAttachmentIndex == -1)
                        {
                            // add a new attachment
                            m_ActiveColorAttachmentDescriptors[currentAttachmentIdx] = currentAttachmentDescriptor;
                            bool passHasClearColor = (pass.clearFlag & ClearFlag.Color) != 0;
                            m_ActiveColorAttachmentDescriptors[currentAttachmentIdx].ConfigureTarget(colorHandle.nameID, !passHasClearColor, true);

                            if (pass.colorAttachmentHandles[i] == m_CameraColorTarget.handle && needCustomCameraColorClear && (cameraClearFlag & ClearFlag.Color) != 0)
                                m_ActiveColorAttachmentDescriptors[currentAttachmentIdx].ConfigureClear(cameraData.backgroundColor, 1.0f, 0);
                            else if (passHasClearColor)
                                m_ActiveColorAttachmentDescriptors[currentAttachmentIdx].ConfigureClear(CoreUtils.ConvertSRGBToActiveColorSpace(pass.clearColor), 1.0f, 0);

                            pass.m_ColorAttachmentIndices[i] = currentAttachmentIdx;
                            currentAttachmentIdx++;
                            m_RenderPassesAttachmentCount[currentPassHash]++;
                        }
                        else
                        {
                            // attachment was already present
                            pass.m_ColorAttachmentIndices[i] = existingAttachmentIndex;
                        }
                    }

                    if (PassHasInputAttachments(pass))
                    {
                        hasInput = true;
                        SetupInputAttachmentIndices(pass);
                    }

                    // TODO: this is redundant and is being setup for each attachment. Needs to be done only once per mergeable pass list (we need to make sure mergeable passes use the same depth!)
                    m_ActiveDepthAttachmentDescriptor = new AttachmentDescriptor(SystemInfo.GetGraphicsFormat(DefaultFormat.DepthStencil));
                    bool passHasClearDepth = (cameraClearFlag & ClearFlag.DepthStencil) != 0;
                    m_ActiveDepthAttachmentDescriptor.ConfigureTarget(pass.overrideCameraTarget ? pass.depthAttachmentHandle.nameID : m_CameraDepthTarget.nameID, !passHasClearDepth, true);

                    if (passHasClearDepth)
                        m_ActiveDepthAttachmentDescriptor.ConfigureClear(Color.black, 1.0f, 0);

                    if (m_UseOptimizedStoreActions)
                        m_ActiveDepthAttachmentDescriptor.storeAction = m_FinalDepthStoreAction;
                }

                if (hasInput)
                    SetupTransientInputAttachments(m_RenderPassesAttachmentCount[currentPassHash]);
            }
        }

        bool IsDepthOnlyRenderTexture(RenderTexture t)
        {
            if (t.graphicsFormat == GraphicsFormat.None)
                return true;
            return false;
        }

        internal void SetNativeRenderPassAttachmentList(SekiaRendererPass renderPass, ref CameraData cameraData, RTHandle passColorAttachment, RTHandle passDepthAttachment, ClearFlag finalClearFlag, Color finalClearColor)
        {
            using (new ProfilingScope(null, Profiling.setAttachmentList))
            {
                int currentPassIndex = renderPass.renderPassQueueIndex;
                Hash128 currentPassHash = m_PassIndexToPassHash[currentPassIndex];
                int[] currentMergeablePasses = m_MergeableRenderPassesMap[currentPassHash];

                // Skip if not the first pass
                if (currentMergeablePasses.First() != currentPassIndex)
                    return;

                m_RenderPassesAttachmentCount[currentPassHash] = 0;

                UpdateFinalStoreActions(currentMergeablePasses, ref cameraData);

                int currentAttachmentIdx = 0;
                foreach (var passIdx in currentMergeablePasses)
                {
                    if (passIdx == -1)
                        break;
                    SekiaRendererPass pass = m_ActiveRenderPassQueue[passIdx];

                    for (int i = 0; i < pass.m_ColorAttachmentIndices.Length; ++i)
                        pass.m_ColorAttachmentIndices[i] = -1;

                    AttachmentDescriptor currentAttachmentDescriptor;
                    var usesTargetTexture = cameraData.targetTexture != null;
                    var depthOnly = (pass.colorAttachmentHandle.rt != null && IsDepthOnlyRenderTexture(pass.colorAttachmentHandle.rt)) || (usesTargetTexture && IsDepthOnlyRenderTexture(cameraData.targetTexture));

                    int samples;
                    RenderTargetIdentifier colorAttachmentTarget;
                    // We are not rendering to Backbuffer so we have the RT and the information with it
                    // while also creating a new RenderTargetIdentifier to ignore the current depth slice (which might get bypassed in XR setup eventually)
                    if (new RenderTargetIdentifier(passColorAttachment.nameID, 0, depthSlice: 0) != BuiltinRenderTextureType.CameraTarget)
                    {
                        currentAttachmentDescriptor = new AttachmentDescriptor(depthOnly ? passColorAttachment.rt.descriptor.depthStencilFormat : passColorAttachment.rt.descriptor.graphicsFormat);
                        samples = passColorAttachment.rt.descriptor.msaaSamples;
                        colorAttachmentTarget = passColorAttachment.nameID;
                    }
                    else // In this case we might be rendering the the targetTexture or the Backbuffer, so less information is available
                    {
                        currentAttachmentDescriptor = new AttachmentDescriptor(pass.renderTargetFormat[0] != GraphicsFormat.None ? pass.renderTargetFormat[0] : UniversalRenderPipeline.MakeRenderTextureGraphicsFormat(cameraData.isHdrEnabled, cameraData.hdrColorBufferPrecision, Graphics.preserveFramebufferAlpha));

                        samples = cameraData.cameraTargetDescriptor.msaaSamples;
                        colorAttachmentTarget = usesTargetTexture ? new RenderTargetIdentifier(cameraData.targetTexture) : BuiltinRenderTextureType.CameraTarget;
                    }

                    currentAttachmentDescriptor.ConfigureTarget(colorAttachmentTarget, ((uint)finalClearFlag & (uint)ClearFlag.Color) == 0, true);

                    if (PassHasInputAttachments(pass))
                        SetupInputAttachmentIndices(pass);

                    // TODO: this is redundant and is being setup for each attachment. Needs to be done only once per mergeable pass list (we need to make sure mergeable passes use the same depth!)
                    m_ActiveDepthAttachmentDescriptor = new AttachmentDescriptor(SystemInfo.GetGraphicsFormat(DefaultFormat.DepthStencil));
                    m_ActiveDepthAttachmentDescriptor.ConfigureTarget(passDepthAttachment.nameID != BuiltinRenderTextureType.CameraTarget ? passDepthAttachment.nameID :
                            (usesTargetTexture ? new RenderTargetIdentifier(cameraData.targetTexture.depthBuffer) : BuiltinRenderTextureType.Depth),
                        ((uint)finalClearFlag & (uint)ClearFlag.Depth) == 0, true);

                    if (finalClearFlag != ClearFlag.None)
                    {
                        // We don't clear color for Overlay render targets, however pipeline set's up depth only render passes as color attachments which we do need to clear
                        if ((cameraData.renderType != CameraRenderType.Overlay || depthOnly && ((uint)finalClearFlag & (uint)ClearFlag.Color) != 0))
                            currentAttachmentDescriptor.ConfigureClear(finalClearColor, 1.0f, 0);
                        if (((uint)finalClearFlag & (uint)ClearFlag.Depth) != 0)
                            m_ActiveDepthAttachmentDescriptor.ConfigureClear(Color.black, 1.0f, 0);
                    }

                    // resolving to the implicit color target's resolve surface TODO: handle m_CameraResolveTarget if present?
                    if (samples > 1)
                    {
                        currentAttachmentDescriptor.ConfigureResolveTarget(colorAttachmentTarget);
                        if (RenderingUtils.MultisampleDepthResolveSupported())
                            m_ActiveDepthAttachmentDescriptor.ConfigureResolveTarget(m_ActiveDepthAttachmentDescriptor.loadStoreTarget);
                    }


                    if (m_UseOptimizedStoreActions)
                    {
                        currentAttachmentDescriptor.storeAction = m_FinalColorStoreAction[0];
                        m_ActiveDepthAttachmentDescriptor.storeAction = m_FinalDepthStoreAction;
                    }

                    int existingAttachmentIndex = FindAttachmentDescriptorIndexInList(currentAttachmentIdx,
                        currentAttachmentDescriptor, m_ActiveColorAttachmentDescriptors);

                    if (existingAttachmentIndex == -1)
                    {
                        // add a new attachment
                        pass.m_ColorAttachmentIndices[0] = currentAttachmentIdx;
                        m_ActiveColorAttachmentDescriptors[currentAttachmentIdx] = currentAttachmentDescriptor;
                        currentAttachmentIdx++;
                        m_RenderPassesAttachmentCount[currentPassHash]++;
                    }
                    else
                    {
                        // attachment was already present
                        pass.m_ColorAttachmentIndices[0] = existingAttachmentIndex;
                    }
                }
            }
        }

        internal void ExecuteNativeRenderPass(ScriptableRenderContext context, SekiaRendererPass renderPass, ref CameraData cameraData, ref RenderingData renderingData)
        {
            using (new ProfilingScope(null, Profiling.execute))
            {
                int currentPassIndex = renderPass.renderPassQueueIndex;
                Hash128 currentPassHash = m_PassIndexToPassHash[currentPassIndex];
                int[] currentMergeablePasses = m_MergeableRenderPassesMap[currentPassHash];

                int validColorBuffersCount = m_RenderPassesAttachmentCount[currentPassHash];

                var depthOnly = (renderPass.colorAttachmentHandle.rt != null && IsDepthOnlyRenderTexture(renderPass.colorAttachmentHandle.rt)) || (cameraData.targetTexture != null && IsDepthOnlyRenderTexture(cameraData.targetTexture));
                bool useDepth = depthOnly || (!renderPass.overrideCameraTarget || (renderPass.overrideCameraTarget && renderPass.depthAttachmentHandle.nameID != BuiltinRenderTextureType.CameraTarget));// &&

                var attachments =
                    new NativeArray<AttachmentDescriptor>(useDepth && !depthOnly ? validColorBuffersCount + 1 : 1, Allocator.Temp);

                for (int i = 0; i < validColorBuffersCount; ++i)
                    attachments[i] = m_ActiveColorAttachmentDescriptors[i];

                if (useDepth && !depthOnly)
                    attachments[validColorBuffersCount] = m_ActiveDepthAttachmentDescriptor;

                var rpDesc = InitializeRenderPassDescriptor(ref cameraData, renderPass);

                int validPassCount = GetValidPassIndexCount(currentMergeablePasses);

                var attachmentIndicesCount = GetSubPassAttachmentIndicesCount(renderPass);

                var attachmentIndices = new NativeArray<int>(!depthOnly ? (int)attachmentIndicesCount : 0, Allocator.Temp);
                if (!depthOnly)
                {
                    for (int i = 0; i < attachmentIndicesCount; ++i)
                    {
                        attachmentIndices[i] = renderPass.m_ColorAttachmentIndices[i];
                    }
                }

                if (validPassCount == 1 || currentMergeablePasses[0] == currentPassIndex) // Check if it's the first pass
                {
                    if (PassHasInputAttachments(renderPass))
                        Debug.LogWarning("First pass in a RenderPass should not have input attachments.");

                    context.BeginRenderPass(rpDesc.w, rpDesc.h, Math.Max(rpDesc.samples, 1), attachments,
                        useDepth ? (!depthOnly ? validColorBuffersCount : 0) : -1);
                    attachments.Dispose();

                    context.BeginSubPass(attachmentIndices);

                    m_LastBeginSubpassPassIndex = currentPassIndex;
                }
                else
                {
                    // Regarding input attachments, currently we always recreate a new subpass if it contains input attachments
                    // This might not the most optimal way though and it should be investigated in the future
                    // Whether merging subpasses with matching input attachments is a more viable option
                    if (!AreAttachmentIndicesCompatible(m_ActiveRenderPassQueue[m_LastBeginSubpassPassIndex], m_ActiveRenderPassQueue[currentPassIndex]))
                    {
                        context.EndSubPass();
                        if (PassHasInputAttachments(m_ActiveRenderPassQueue[currentPassIndex]))
                            context.BeginSubPass(attachmentIndices, m_ActiveRenderPassQueue[currentPassIndex].m_InputAttachmentIndices);
                        else
                            context.BeginSubPass(attachmentIndices);

                        m_LastBeginSubpassPassIndex = currentPassIndex;
                    }
                    else if (PassHasInputAttachments(m_ActiveRenderPassQueue[currentPassIndex]))
                    {
                        context.EndSubPass();
                        context.BeginSubPass(attachmentIndices, m_ActiveRenderPassQueue[currentPassIndex].m_InputAttachmentIndices);

                        m_LastBeginSubpassPassIndex = currentPassIndex;
                    }
                }

                attachmentIndices.Dispose();

                renderPass.Execute(context, ref renderingData);

                // Need to execute it immediately to avoid sync issues between context and cmd buffer
                context.ExecuteCommandBuffer(renderingData.commandBuffer);
                renderingData.commandBuffer.Clear();

                if (validPassCount == 1 || currentMergeablePasses[validPassCount - 1] == currentPassIndex) // Check if it's the last pass
                {
                    context.EndSubPass();
                    context.EndRenderPass();

                    m_LastBeginSubpassPassIndex = 0;
                }

                for (int i = 0; i < m_ActiveColorAttachmentDescriptors.Length; ++i)
                {
                    m_ActiveColorAttachmentDescriptors[i] = RenderingUtils.emptyAttachment;
                    m_IsActiveColorAttachmentTransient[i] = false;
                }

                m_ActiveDepthAttachmentDescriptor = RenderingUtils.emptyAttachment;
            }
        }

        internal void SetupInputAttachmentIndices(SekiaRendererPass pass)
        {
            var validInputBufferCount = GetValidInputAttachmentCount(pass);
            pass.m_InputAttachmentIndices = new NativeArray<int>(validInputBufferCount, Allocator.Temp);
            for (int i = 0; i < validInputBufferCount; i++)
            {
                pass.m_InputAttachmentIndices[i] = FindAttachmentDescriptorIndexInList(pass.m_InputAttachments[i], m_ActiveColorAttachmentDescriptors);
                if (pass.m_InputAttachmentIndices[i] == -1)
                {
                    Debug.LogWarning("RenderPass Input attachment not found in the current RenderPass");
                    continue;
                }

                // Only update it as long as it has default value - if it was changed once, we assume it'll be memoryless in the whole RenderPass
                if (!m_IsActiveColorAttachmentTransient[pass.m_InputAttachmentIndices[i]])
                {
                    m_IsActiveColorAttachmentTransient[pass.m_InputAttachmentIndices[i]] = pass.IsInputAttachmentTransient(i);
                }
            }
        }

        internal void SetupTransientInputAttachments(int attachmentCount)
        {
            for (int i = 0; i < attachmentCount; ++i)
            {
                if (!m_IsActiveColorAttachmentTransient[i])
                    continue;

                m_ActiveColorAttachmentDescriptors[i].loadAction = RenderBufferLoadAction.DontCare;
                m_ActiveColorAttachmentDescriptors[i].storeAction = RenderBufferStoreAction.DontCare;
                // We change the target of the descriptor for it to be initialized engine-side as a transient resource.
                m_ActiveColorAttachmentDescriptors[i].loadStoreTarget = BuiltinRenderTextureType.None;
            }
        }

        internal static uint GetSubPassAttachmentIndicesCount(SekiaRendererPass pass)
        {
            uint numValidAttachments = 0;

            foreach (var attIdx in pass.m_ColorAttachmentIndices)
            {
                if (attIdx >= 0)
                    ++numValidAttachments;
            }

            return numValidAttachments;
        }

        internal static bool AreAttachmentIndicesCompatible(SekiaRendererPass lastSubPass, SekiaRendererPass currentSubPass)
        {
            uint lastSubPassAttCount = GetSubPassAttachmentIndicesCount(lastSubPass);
            uint currentSubPassAttCount = GetSubPassAttachmentIndicesCount(currentSubPass);

            if (currentSubPassAttCount > lastSubPassAttCount)
                return false;

            uint numEqualAttachments = 0;
            for (int currPassIdx = 0; currPassIdx < currentSubPassAttCount; ++currPassIdx)
            {
                for (int lastPassIdx = 0; lastPassIdx < lastSubPassAttCount; ++lastPassIdx)
                {
                    if (currentSubPass.m_ColorAttachmentIndices[currPassIdx] == lastSubPass.m_ColorAttachmentIndices[lastPassIdx])
                        numEqualAttachments++;
                }
            }

            return (numEqualAttachments == currentSubPassAttCount);
        }

        internal static uint GetValidColorAttachmentCount(AttachmentDescriptor[] colorAttachments)
        {
            uint nonNullColorBuffers = 0;
            if (colorAttachments != null)
            {
                foreach (var attachment in colorAttachments)
                {
                    if (attachment != RenderingUtils.emptyAttachment)
                        ++nonNullColorBuffers;
                }
            }
            return nonNullColorBuffers;
        }

        internal static int GetValidInputAttachmentCount(SekiaRendererPass renderPass)
        {
            var length = renderPass.m_InputAttachments.Length;
            if (length != 8) // overriden, there are attachments
                return length;
            else
            {
                for (int i = 0; i < length; ++i)
                {
                    if (renderPass.m_InputAttachments[i] == null)
                        return i;
                }
                return length;
            }
        }

        internal static int FindAttachmentDescriptorIndexInList(int attachmentIdx, AttachmentDescriptor attachmentDescriptor, AttachmentDescriptor[] attachmentDescriptors)
        {
            int existingAttachmentIndex = -1;
            for (int i = 0; i <= attachmentIdx; ++i)
            {
                AttachmentDescriptor att = attachmentDescriptors[i];

                if (att.loadStoreTarget == attachmentDescriptor.loadStoreTarget && att.graphicsFormat == attachmentDescriptor.graphicsFormat)
                {
                    existingAttachmentIndex = i;
                    break;
                }
            }

            return existingAttachmentIndex;
        }

        internal static int FindAttachmentDescriptorIndexInList(RenderTargetIdentifier target, AttachmentDescriptor[] attachmentDescriptors)
        {
            for (int i = 0; i < attachmentDescriptors.Length; i++)
            {
                AttachmentDescriptor att = attachmentDescriptors[i];
                if (att.loadStoreTarget == target)
                    return i;
            }

            return -1;
        }

        internal static int GetValidPassIndexCount(int[] array)
        {
            if (array == null)
                return 0;

            for (int i = 0; i < array.Length; ++i)
            {
                if (array[i] == -1)
                    return i;
            }
            return array.Length - 1;
        }

        internal static RTHandle GetFirstAllocatedRTHandle(SekiaRendererPass pass)
        {
            for (int i = 0; i < pass.colorAttachmentHandles.Length; ++i)
            {
                if (pass.colorAttachmentHandles[i].rt != null)
                    return pass.colorAttachmentHandles[i];
            }
            return pass.colorAttachmentHandles[0];
        }

        internal static bool PassHasInputAttachments(SekiaRendererPass renderPass)
        {
            return renderPass.m_InputAttachments.Length != 8 || renderPass.m_InputAttachments[0] != null;
        }

        internal static Hash128 CreateRenderPassHash(int width, int height, int depthID, int sample, uint hashIndex)
        {
            return new Hash128((uint)(width << 4) + (uint)height, (uint)depthID, (uint)sample, hashIndex);
        }

        internal static Hash128 CreateRenderPassHash(RenderPassDescriptor desc, uint hashIndex)
        {
            return CreateRenderPassHash(desc.w, desc.h, desc.depthID, desc.samples, hashIndex);
        }

        internal RenderPassDescriptor InitializeRenderPassDescriptor(ref CameraData cameraData, SekiaRendererPass renderPass)
        {
            RenderTextureDescriptor targetRT;
            if (!renderPass.overrideCameraTarget || (renderPass.colorAttachmentHandle.rt == null && renderPass.depthAttachmentHandle.rt == null))
            {
                targetRT = cameraData.cameraTargetDescriptor;

                // In this case we want to rely on the pixelWidth/Height as the texture could be scaled from a script later and etc.
                // and it's new dimensions might not be reflected on the targetTexture. This also applies to camera stacks rendering to a target texture.
                if (cameraData.targetTexture != null)
                {
                    targetRT.width = cameraData.pixelWidth;
                    targetRT.height = cameraData.pixelHeight;
                }
            }
            else
            {
                var handle = GetFirstAllocatedRTHandle(renderPass);
                targetRT = handle.rt != null ? handle.rt.descriptor : renderPass.depthAttachmentHandle.rt.descriptor;
            }

            var depthTarget = renderPass.overrideCameraTarget ? renderPass.depthAttachmentHandle : cameraDepthTargetHandle;
            var depthID = (targetRT.graphicsFormat == GraphicsFormat.None && targetRT.depthStencilFormat != GraphicsFormat.None) ? renderPass.colorAttachmentHandle.GetHashCode() : depthTarget.GetHashCode();

            return new RenderPassDescriptor(targetRT.width, targetRT.height, targetRT.msaaSamples, depthID);
        }
        #endregion




        internal RenderingMode renderingModeActual => GlobalData.Instance.m_RenderingMode == RenderingMode.Deferred &&
            (GL.wireframe || //wireframe rendering不支持延迟渲染
            GlobalData.Instance.m_DeferredLights == null || //
            !GlobalData.Instance.m_DeferredLights.IsRuntimeSupportedThisFrame() || //
            GlobalData.Instance.m_DeferredLights.IsOverlay) //
        ? RenderingMode.Forward //如果不支持延迟管线则回退为前向渲染
        : GlobalData.Instance.m_RenderingMode;

        internal bool accurateGbufferNormals => GlobalData.Instance.m_DeferredLights != null ?
            GlobalData.Instance.m_DeferredLights.AccurateGbufferNormals : false;

        public SekiaRenderer(SekiaRendererData data)
        {
            foreach (var feature in data.m_RendererFeatures)
            {
                if (feature == null)
                    continue;

                feature.Create();
                m_RendererFeatures.Add(feature);
            }

            ResetNativeRenderPassFrameData();
            useRenderPassEnabled = SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;
            Clear(CameraRenderType.Base);
            m_ActiveRenderPassQueue.Clear();

            if (SekiaPipeline.Instance.asset)
            {
                m_StoreActionsOptimizationSetting = UniversalRenderPipeline.asset.storeActionsOptimization;
            }

            m_UseOptimizedStoreActions = m_StoreActionsOptimizationSetting != StoreActionsOptimization.Store;

            this.stripShadowsOffVariants = true;
            this.stripAdditionalLightOffVariants = true;

            if (GlobalData.Instance.m_RenderingMode == RenderingMode.Deferred)
            {
                //避免使用旧API：使用Vulkan替
                //这个设置用于编辑器报错 提示用户修改API列表
                unsupportedGraphicsDeviceTypes = new GraphicsDeviceType[]
                {
                    GraphicsDeviceType.OpenGLCore,
                    GraphicsDeviceType.OpenGLES2,
                    GraphicsDeviceType.OpenGLES3
                };
            }
        }

        //Clear → SetupCullingParameters → Setup → Execute
        public void Setup(ScriptableRenderContext context, ref RenderingData renderingData)
        {


            ref CameraData cameraData = ref renderingData.cameraData;
            RenderTextureDescriptor cameraTargetDescriptor = cameraData.cameraTargetDescriptor;
            var cmd = renderingData.commandBuffer;

            //光照更新
            GlobalData.Instance.m_ForwardLights.ProcessLights(ref renderingData);
            GlobalData.Instance.m_DeferredLights.ResolveMixedLightingMode(ref renderingData);
            GlobalData.Instance.m_DeferredLights.IsOverlay = cameraData.renderType == CameraRenderType.Overlay;

            if (cameraData.renderType == CameraRenderType.Base)
            {
                using (new ProfilingScope(null, GlobalData.Profiling.createCameraRenderTarget))
                {
                    var colorDesc = cameraTargetDescriptor;
                    colorDesc.useMipMap = false;
                    colorDesc.autoGenerateMips = false;
                    colorDesc.depthBufferBits = (int)DepthBits.None;
                    GlobalData.Instance.m_ColorBufferSystem.SetCameraSettings(colorDesc, FilterMode.Bilinear);
                    var backBuffer = GlobalData.Instance.m_ColorBufferSystem.GetBackBuffer(cmd); //初始化双颜色Buffer
                    cmd.SetGlobalTexture("_CameraColorTexture", backBuffer.nameID);

                    var depthDesc = cameraTargetDescriptor;
                    depthDesc.useMipMap = false;
                    depthDesc.autoGenerateMips = false;
                    depthDesc.bindMS = false;
                    depthDesc.graphicsFormat = GraphicsFormat.None;
                    depthDesc.depthStencilFormat = UniversalRenderer.k_DepthStencilFormat;
                    RenderingUtils.ReAllocateIfNeeded(ref GlobalData.Instance.m_CameraDepthAttachment,
                        depthDesc, FilterMode.Point, TextureWrapMode.Clamp, name: "_CameraDepthAttachment");
                    cmd.SetGlobalTexture(GlobalData.Instance.m_CameraDepthAttachment.name, GlobalData.Instance.m_CameraDepthAttachment.nameID);
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

            }

            //初始化目标RT
            GlobalData.Instance.m_ActiveCameraColorAttachment = GlobalData.Instance.m_ColorBufferSystem.PeekBackBuffer();
            GlobalData.Instance.m_ActiveCameraDepthAttachment = GlobalData.Instance.m_CameraDepthAttachment;
            ConfigureCameraTarget(GlobalData.Instance.m_ActiveCameraColorAttachment, GlobalData.Instance.m_ActiveCameraDepthAttachment);

            //初始化CopyDepthRT
            /*
            {
                var copyDepthDesc = cameraTargetDescriptor;
                copyDepthDesc.graphicsFormat = GraphicsFormat.R32_SFloat;
                copyDepthDesc.depthStencilFormat = GraphicsFormat.None;
                copyDepthDesc.depthBufferBits = 0;
                copyDepthDesc.msaaSamples = 1;
                RenderingUtils.ReAllocateIfNeeded(ref GlobalData.Instance.m_DepthTexture,
                    copyDepthDesc, FilterMode.Point, wrapMode: TextureWrapMode.Clamp, name: "_CameraDepthTexture");
                cmd.SetGlobalTexture(GlobalData.Instance.m_DepthTexture.name, GlobalData.Instance.m_DepthTexture.nameID);
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }
            */
        }

        public void SetupLights(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            GlobalData.Instance.m_ForwardLights.Setup(context, ref renderingData);
            GlobalData.Instance.m_DeferredLights.SetupLights(context, ref renderingData);
        }

        /// <inheritdoc />
        public void SetupCullingParameters(ref ScriptableCullingParameters cullingParameters, ref CameraData cameraData)
        {
            // TODO: PerObjectCulling also affect reflection probes. Enabling it for now.
            // if (asset.additionalLightsRenderingMode == LightRenderingMode.Disabled ||
            //     asset.maxAdditionalLightsCount == 0)
            // {
            //     cullingParameters.cullingOptions |= CullingOptions.DisablePerObjectCulling;
            // }

            // We disable shadow casters if both shadow casting modes are turned off
            // or the shadow distance has been turned down to zero
            bool isShadowCastingDisabled = !SekiaPipeline.Instance.asset.supportsMainLightShadows && !SekiaPipeline.Instance.asset.supportsAdditionalLightShadows;
            bool isShadowDistanceZero = Mathf.Approximately(cameraData.maxShadowDistance, 0.0f);
            if (isShadowCastingDisabled || isShadowDistanceZero)
            {
                cullingParameters.cullingOptions &= ~CullingOptions.ShadowCasters;
            }

            if (this.renderingModeActual == RenderingMode.Deferred)
                cullingParameters.maximumVisibleLights = 0xFFFF;
            else
            {
                // We set the number of maximum visible lights allowed and we add one for the mainlight...
                //
                // Note: However ScriptableRenderContext.Cull() does not differentiate between light types.
                //       If there is no active main light in the scene, ScriptableRenderContext.Cull() might return  ( cullingParameters.maximumVisibleLights )  visible additional lights.
                //       i.e ScriptableRenderContext.Cull() might return  ( UniversalRenderPipeline.maxVisibleAdditionalLights + 1 )  visible additional lights !
                cullingParameters.maximumVisibleLights = UniversalRenderPipeline.maxVisibleAdditionalLights + 1;
            }
            cullingParameters.shadowDistance = cameraData.maxShadowDistance;

            cullingParameters.conservativeEnclosingSphere = SekiaPipeline.Instance.asset.conservativeEnclosingSphere;

            cullingParameters.numIterationsEnclosingSphere = SekiaPipeline.Instance.asset.numIterationsEnclosingSphere;
        }

        public void FinishRendering(CommandBuffer cmd)
        {
            GlobalData.Instance.m_ColorBufferSystem.Clear();
            GlobalData.Instance.m_ActiveCameraColorAttachment = null;
            GlobalData.Instance.m_ActiveCameraDepthAttachment = null;
        }

        internal void SwapColorBuffer(CommandBuffer cmd)
        {
            GlobalData.Instance.m_ColorBufferSystem.Swap();
            var backBuffer = GlobalData.Instance.m_ColorBufferSystem.GetBackBuffer(cmd);
            ConfigureCameraColorTarget(backBuffer);
            GlobalData.Instance.m_ActiveCameraColorAttachment = backBuffer;
            cmd.SetGlobalTexture("_CameraColorTexture", GlobalData.Instance.m_ActiveCameraColorAttachment.nameID);
        }

        public void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;
            Camera camera = cameraData.camera;
            var cmd = renderingData.commandBuffer;

            //参考：AddRenderPasses
            //Feature的AddRenderPasses
            {
                using var profScope = new ProfilingScope(null, GlobalData.Profiling.addRenderPasses);
                for (int i = 0; i < m_RendererFeatures.Count; ++i)
                {
                    if (!m_RendererFeatures[i].isActive)
                        continue;
                    m_RendererFeatures[i].AddRenderPasses(this, ref renderingData);
                }

#if UNITY_EDITOR
                int count = m_ActiveRenderPassQueue.Count;
                for (int i = count - 1; i >= 0; i--)
                {
                    if (m_ActiveRenderPassQueue[i] == null)
                    {
                        m_ActiveRenderPassQueue.RemoveAt(i);
                        Debug.LogError("RenderFeature列表中包含null项");
                    }
                }
#endif
            }

            //参考：SetupRenderPasses
            //Feature的SetupRenderPasses
            {
                using var profScope = new ProfilingScope(null, GlobalData.Profiling.setupRenderPasses);

                for (int i = 0; i < m_RendererFeatures.Count; ++i)
                {
                    if (!m_RendererFeatures[i].isActive)
                        continue;

                    //初始化RenderFeature
                    m_RendererFeatures[i].SetupRenderPasses(this, in renderingData);
                }
            }

            //参考：InternalStartRendering
            //Pass的OnCameraSetup
            {
                using (new ProfilingScope(null, GlobalData.Profiling.internalStartRendering))
                {
                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                    {
                        m_ActiveRenderPassQueue[i].OnCameraSetup(cmd, ref renderingData);
                    }
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            //参考：ClearRenderingState
            {
                using var profScope = new ProfilingScope(null, GlobalData.Profiling.clearRenderingState);
                {
                    // Reset per-camera shader keywords. They are enabled depending on which render passes are executed.
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.MainLightShadows);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.MainLightShadowCascades);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightsVertex);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightsPixel);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.ForwardPlus);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightShadows);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.ReflectionProbeBlending);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.ReflectionProbeBoxProjection);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.SoftShadows);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.MixedLightingSubtractive); // Backward compatibility
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.LightmapShadowMixing);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.ShadowsShadowMask);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.LinearToSRGBConversion);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.LightLayers);
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            //参考：SetupNativeRenderPassFrameData
            {
                using (new ProfilingScope(null, GlobalData.Profiling.setupFrameData))
                {
                    int lastPassIndex = m_ActiveRenderPassQueue.Count - 1;

                    // Make sure the list is already sorted!

                    m_MergeableRenderPassesMap.Clear();
                    m_RenderPassesAttachmentCount.Clear();
                    uint currentHashIndex = 0;
                    // reset all the passes last pass flag
                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                    {
                        var renderPass = m_ActiveRenderPassQueue[i];

                        renderPass.renderPassQueueIndex = i;

                        bool RPEnabled = IsRenderPassEnabled(renderPass);
                        if (!RPEnabled)
                            continue;

                        var rpDesc = InitializeRenderPassDescriptor(ref cameraData, renderPass);

                        Hash128 hash = CreateRenderPassHash(rpDesc, currentHashIndex);

                        m_PassIndexToPassHash[i] = hash;

                        if (!m_MergeableRenderPassesMap.ContainsKey(hash))
                        {
                            m_MergeableRenderPassesMap.Add(hash, m_MergeableRenderPassesMapArrays[m_MergeableRenderPassesMap.Count]);
                            m_RenderPassesAttachmentCount.Add(hash, 0);
                        }
                        else if (m_MergeableRenderPassesMap[hash][GetValidPassIndexCount(m_MergeableRenderPassesMap[hash]) - 1] != (i - 1))
                        {
                            // if the passes are not sequential we want to split the current mergeable passes list. So we increment the hashIndex and update the hash

                            currentHashIndex++;
                            hash = CreateRenderPassHash(rpDesc, currentHashIndex);

                            m_PassIndexToPassHash[i] = hash;

                            m_MergeableRenderPassesMap.Add(hash, m_MergeableRenderPassesMapArrays[m_MergeableRenderPassesMap.Count]);
                            m_RenderPassesAttachmentCount.Add(hash, 0);
                        }

                        m_MergeableRenderPassesMap[hash][GetValidPassIndexCount(m_MergeableRenderPassesMap[hash])] = i;
                    }

                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                    {
                        m_ActiveRenderPassQueue[i].m_ColorAttachmentIndices = new NativeArray<int>(8, Allocator.Temp);
                        m_ActiveRenderPassQueue[i].m_InputAttachmentIndices = new NativeArray<int>(8, Allocator.Temp);
                    }
                }
            }

            //光照设置
            {
                using (new ProfilingScope(null, GlobalData.Profiling.setupLights))
                {
                    SetupLights(context, ref renderingData);
                }
            }

            //逐相机参数设置
            {
                using (new ProfilingScope(null, GlobalData.Profiling.setupCamera))
                {
                    GlobalLogic.SetPerCameraShaderVariables(cmd, ref cameraData);
                    if (cameraData.renderType == CameraRenderType.Overlay)
                    {
                        SetPerCameraClippingPlaneProperties(cmd, ref cameraData);
                        SetPerCameraBillboardProperties(cmd, ref cameraData);
                    }

#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
                    //Triggers dispatch per camera, all global parameters should have been setup at this stage.
                    UnityEngine.VFX.VFXManager.ProcessCameraCommand(camera, cmd);
#endif
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            //Pass的Configure
            {
                using (new ProfilingScope(null, GlobalData.Profiling.configure))
                {
                    foreach (var pass in m_ActiveRenderPassQueue)
                        pass.Configure(cmd, cameraData.cameraTargetDescriptor);
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            //SetRenderTarget = > pass.Execute
            foreach (var pass in m_ActiveRenderPassQueue)
            {
                SetRenderPassAttachments(cmd, pass, ref cameraData);
                context.ExecuteCommandBuffer(cmd); //ensure SetRenderTarget is called before RenderPass.Execute
                cmd.Clear();

                if (IsRenderPassEnabled(pass) && cameraData.isRenderPassSupportedCamera)
                    ExecuteNativeRenderPass(context, pass, ref cameraData, ref renderingData);
                else
                    pass.Execute(context, ref renderingData);
            }

            //bool drawGizmos = UniversalRenderPipelineDebugDisplaySettings.Instance.renderingSettings.sceneOverrideMode == DebugSceneOverrideMode.None;
            //if(drawGizmos)
            //插个pass做这个
            DrawGizmos(context, camera, GizmoSubset.PreImageEffects, ref renderingData);
            DrawWireOverlay(context, camera);
            DrawGizmos(context, camera, GizmoSubset.PostImageEffects, ref renderingData);

            //参考InternalFinishRendering
            //Pass的FrameCleanup和OnFinishCameraStackRendering
            {
                using (new ProfilingScope(null, GlobalData.Profiling.internalFinishRendering))
                {
                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                        m_ActiveRenderPassQueue[i].OnCameraCleanup(renderingData.commandBuffer);

                    // Happens when rendering the last camera in the camera stack.
                    if (cameraData.resolveFinalTarget)
                    {
                        for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                            m_ActiveRenderPassQueue[i].OnFinishCameraStackRendering(renderingData.commandBuffer);

                        FinishRendering(renderingData.commandBuffer);
                    }
                    m_ActiveRenderPassQueue.Clear();
                }

                ResetNativeRenderPassFrameData();

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
            {
                m_ActiveRenderPassQueue[i].m_ColorAttachmentIndices.Dispose();
                m_ActiveRenderPassQueue[i].m_InputAttachmentIndices.Dispose();
            }
        }

        public void SetRenderPassAttachments(CommandBuffer cmd, SekiaRendererPass renderPass, ref CameraData cameraData)
        {
#pragma warning disable 0618 // Obsolete usage: Using deprecated RenderTargetIdentifiers to ensure backwards compatibility with passes set with RenderTargetIdentifier
            Camera camera = cameraData.camera;
            ClearFlag cameraClearFlag = GlobalLogic.GetCameraClearFlag(ref cameraData);

            // Invalid configuration - use current attachment setup
            // Note: we only check color buffers. This is only technically correct because for shadowmaps and depth only passes
            // we bind depth as color and Unity handles it underneath. so we never have a situation that all color buffers are null and depth is bound.
            uint validColorBuffersCount = RenderingUtils.GetValidColorBufferCount(renderPass.colorAttachments);
            if (validColorBuffersCount == 0)
                return;

            // We use a different code path for MRT since it calls a different version of API SetRenderTarget
            if (RenderingUtils.IsMRT(renderPass.colorAttachments))
            {
                // In the MRT path we assume that all color attachments are REAL color attachments,
                // and that the depth attachment is a REAL depth attachment too.

                // Determine what attachments need to be cleared. ----------------

                bool needCustomCameraColorClear = false;
                bool needCustomCameraDepthClear = false;

                int cameraColorTargetIndex = RenderingUtils.IndexOf(renderPass.colorAttachments, m_CameraColorTarget.nameID);
                if (cameraColorTargetIndex != -1 && (m_FirstTimeCameraColorTargetIsBound))
                {
                    m_FirstTimeCameraColorTargetIsBound = false; // register that we did clear the camera target the first time it was bound

                    // Overlay cameras composite on top of previous ones. They don't clear.
                    // MTT: Commented due to not implemented yet
                    //                    if (renderingData.cameraData.renderType == CameraRenderType.Overlay)
                    //                        clearFlag = ClearFlag.None;

                    // We need to specifically clear the camera color target.
                    // But there is still a chance we don't need to issue individual clear() on each render-targets if they all have the same clear parameters.
                    needCustomCameraColorClear = (cameraClearFlag & ClearFlag.Color) != (renderPass.clearFlag & ClearFlag.Color)
                        || cameraData.backgroundColor != renderPass.clearColor;
                }

                // Note: if we have to give up the assumption that no depthTarget can be included in the MRT colorAttachments, we might need something like this:
                // int cameraTargetDepthIndex = IndexOf(renderPass.colorAttachments, m_CameraDepthTarget);
                // if( !renderTargetAlreadySet && cameraTargetDepthIndex != -1 && m_FirstTimeCameraDepthTargetIsBound)
                // { ...
                // }
                var depthTargetID = m_CameraDepthTarget.nameID;
                if (renderPass.depthAttachment == depthTargetID && m_FirstTimeCameraDepthTargetIsBound)
                {
                    m_FirstTimeCameraDepthTargetIsBound = false;
                    needCustomCameraDepthClear = (cameraClearFlag & ClearFlag.DepthStencil) != (renderPass.clearFlag & ClearFlag.DepthStencil);
                }

                // Perform all clear operations needed. ----------------
                // We try to minimize calls to SetRenderTarget().

                // We get here only if cameraColorTarget needs to be handled separately from the rest of the color attachments.
                if (needCustomCameraColorClear)
                {
                    // Clear camera color render-target separately from the rest of the render-targets.

                    if ((cameraClearFlag & ClearFlag.Color) != 0 && (!IsRenderPassEnabled(renderPass) || !cameraData.isRenderPassSupportedCamera))
                        SetRenderTarget(cmd, renderPass.colorAttachmentHandles[cameraColorTargetIndex], renderPass.depthAttachmentHandle, ClearFlag.Color, cameraData.backgroundColor);

                    if ((renderPass.clearFlag & ClearFlag.Color) != 0)
                    {
                        uint otherTargetsCount = RenderingUtils.CountDistinct(renderPass.colorAttachments, m_CameraColorTarget.nameID);
                        var nonCameraAttachments = m_TrimmedColorAttachmentCopies[otherTargetsCount];
                        int writeIndex = 0;
                        for (int readIndex = 0; readIndex < renderPass.colorAttachments.Length; ++readIndex)
                        {
                            if (renderPass.colorAttachments[readIndex] != m_CameraColorTarget.nameID && renderPass.colorAttachments[readIndex] != 0)
                            {
                                nonCameraAttachments[writeIndex] = renderPass.colorAttachments[readIndex];
                                ++writeIndex;
                            }
                        }

                        if (writeIndex != otherTargetsCount)
                            Debug.LogError("writeIndex and otherTargetsCount values differed. writeIndex:" + writeIndex + " otherTargetsCount:" + otherTargetsCount);

                        if (!IsRenderPassEnabled(renderPass) || !cameraData.isRenderPassSupportedCamera)
                            SetRenderTarget(cmd, new RTHandle[1] /*nonCameraAttachments*/, m_CameraDepthTarget.handle, ClearFlag.Color, renderPass.clearColor);
                    }
                }

                // Bind all attachments, clear color only if there was no custom behaviour for cameraColorTarget, clear depth as needed.
                ClearFlag finalClearFlag = ClearFlag.None;
                finalClearFlag |= needCustomCameraDepthClear ? (cameraClearFlag & ClearFlag.DepthStencil) : (renderPass.clearFlag & ClearFlag.DepthStencil);
                finalClearFlag |= needCustomCameraColorClear ? (IsRenderPassEnabled(renderPass) ? (cameraClearFlag & ClearFlag.Color) : 0) : (renderPass.clearFlag & ClearFlag.Color);

                if (IsRenderPassEnabled(renderPass) && cameraData.isRenderPassSupportedCamera)
                    SetNativeRenderPassMRTAttachmentList(renderPass, ref cameraData, needCustomCameraColorClear, finalClearFlag);

                // Only setup render target if current render pass attachments are different from the active ones.
                if (!RenderingUtils.SequenceEqual(renderPass.colorAttachments, m_ActiveColorAttachments) || renderPass.depthAttachment != m_ActiveDepthAttachment || finalClearFlag != ClearFlag.None)
                {
                    int lastValidRTindex = RenderingUtils.LastValid(renderPass.colorAttachments);
                    if (lastValidRTindex >= 0)
                    {
                        int rtCount = lastValidRTindex + 1;
                        var trimmedAttachments = m_TrimmedColorAttachmentCopies[rtCount];
                        for (int i = 0; i < rtCount; ++i)
                            trimmedAttachments[i] = renderPass.colorAttachments[i];

                        if (!IsRenderPassEnabled(renderPass) || !cameraData.isRenderPassSupportedCamera)
                        {
                            if (renderPass.m_UsesRTHandles)
                            {
                                var depthAttachment = m_CameraDepthTarget.handle;

                                if (renderPass.overrideCameraTarget)
                                    depthAttachment = renderPass.depthAttachmentHandle;
                                else
                                    m_FirstTimeCameraDepthTargetIsBound = false;

                                // Only one RTHandle is necessary to set the viewport in dynamic scaling, use depth
                                SetRenderTarget(cmd, new RTHandle[1] /*nonCameraAttachments*/, depthAttachment, finalClearFlag, renderPass.clearColor);
                            }
                            else
                            {
                                var depthAttachment = m_CameraDepthTarget.handle;

                                if (renderPass.overrideCameraTarget)
                                    depthAttachment = renderPass.depthAttachmentHandle;
                                else
                                    m_FirstTimeCameraDepthTargetIsBound = false;

                                SetRenderTarget(cmd, new RTHandle[1] /*nonCameraAttachments*/, depthAttachment, finalClearFlag, renderPass.clearColor);
                            }
                        }
                    }
                }
            }
            else
            {
                // Currently in non-MRT case, color attachment can actually be a depth attachment.
                //pass在config中设置渲染目标 没有设置时使用默认值
                var passColorAttachment = renderPass.m_UsesRTHandles ?
                    new RTHandleRenderTargetIdentifierCompat { handle = renderPass.colorAttachmentHandle } :
                new RTHandleRenderTargetIdentifierCompat { fallback = renderPass.colorAttachment };
                var passDepthAttachment = renderPass.m_UsesRTHandles ?
                    new RTHandleRenderTargetIdentifierCompat { handle = renderPass.depthAttachmentHandle } :
                new RTHandleRenderTargetIdentifierCompat { fallback = renderPass.depthAttachment };

                // When render pass doesn't call ConfigureTarget we assume it's expected to render to camera target
                // which might be backbuffer or the framebuffer render textures.

                //根据用户设置指定pass的渲染目标
                if (!renderPass.overrideCameraTarget)
                {
                    // Default render pass attachment for passes before main rendering is current active
                    // early return so we don't change current render target setup.
                    if (renderPass.renderPassEvent < RenderPassEvent.BeforeRenderingPrePasses)
                        return;

                    // Otherwise default is the pipeline camera target.
                    passColorAttachment = m_CameraColorTarget;
                    passDepthAttachment = m_CameraDepthTarget;
                }

                //有Color / Depth /Stencil可以清除
                ClearFlag finalClearFlag = ClearFlag.None;
                Color finalClearColor;

                //第一次渲染到主颜色目标时 清理颜色
                if (passColorAttachment.nameID == m_CameraColorTarget.nameID && m_FirstTimeCameraColorTargetIsBound)
                {
                    m_FirstTimeCameraColorTargetIsBound = false; // register that we did clear the camera target the first time it was bound

                    finalClearFlag |= (cameraClearFlag & ClearFlag.Color);

                    // on platforms that support Load and Store actions having the clear flag means that the action will be DontCare, which is something we want when the color target is bound the first time
                    if (SystemInfo.usesLoadStoreActions)
                        finalClearFlag |= renderPass.clearFlag;

                    finalClearColor = cameraData.backgroundColor;

                    if (m_FirstTimeCameraDepthTargetIsBound)
                    {
                        // m_CameraColorTarget can be an opaque pointer to a RenderTexture with depth-surface.
                        // We cannot infer this information here, so we must assume both camera color and depth are first-time bound here (this is the legacy behaviour).
                        m_FirstTimeCameraDepthTargetIsBound = false;
                        finalClearFlag |= (cameraClearFlag & ClearFlag.DepthStencil);
                    }
                }
                else
                {
                    finalClearFlag |= (renderPass.clearFlag & ClearFlag.Color);
                    finalClearColor = renderPass.clearColor;
                }

                // Condition (m_CameraDepthTarget!=BuiltinRenderTextureType.CameraTarget) below prevents m_FirstTimeCameraDepthTargetIsBound flag from being reset during non-camera passes (such as Color Grading LUT). This ensures that in those cases, cameraDepth will actually be cleared during the later camera pass.
                if (new RenderTargetIdentifier(m_CameraDepthTarget.nameID, 0, depthSlice: 0) != BuiltinRenderTextureType.CameraTarget && (passDepthAttachment.nameID == m_CameraDepthTarget.nameID || passColorAttachment.nameID == m_CameraDepthTarget.nameID) && m_FirstTimeCameraDepthTargetIsBound)
                {
                    m_FirstTimeCameraDepthTargetIsBound = false;

                    finalClearFlag |= (cameraClearFlag & ClearFlag.DepthStencil);

                    // finalClearFlag |= (cameraClearFlag & ClearFlag.Color);  // <- m_CameraDepthTarget is never a color-surface, so no need to add this here.
                }
                else
                    finalClearFlag |= (renderPass.clearFlag & ClearFlag.DepthStencil);

#if UNITY_EDITOR
                if (CoreUtils.IsSceneFilteringEnabled() && camera.sceneViewFilterMode == Camera.SceneViewFilterMode.ShowFiltered)
                {
                    finalClearColor.a = 0;
                    finalClearFlag &= ~ClearFlag.Depth;
                }
#endif

                // Disabling Native RenderPass if not using RTHandles as we will be relying on info inside handles object
                if (IsRenderPassEnabled(renderPass) && cameraData.isRenderPassSupportedCamera && renderPass.m_UsesRTHandles)
                {
                    SetNativeRenderPassAttachmentList(renderPass, ref cameraData, passColorAttachment.handle, passDepthAttachment.handle, finalClearFlag, finalClearColor);
                }
                else
                {
                    // As alternative we would need a way to check if rts are not going to be used as shader resource
                    bool colorAttachmentChanged = false;
                    for (int i = 0; i < m_ActiveColorAttachments.Length; i++)
                    {
                        if (renderPass.colorAttachments[i] != m_ActiveColorAttachments[i])
                        {
                            colorAttachmentChanged = true;
                            break;
                        }
                    }

                    // Only setup render target if current render pass attachments are different from the active ones
                    if (colorAttachmentChanged || passColorAttachment.nameID != m_ActiveColorAttachments[0] || passDepthAttachment.nameID != m_ActiveDepthAttachment || finalClearFlag != ClearFlag.None ||
                        renderPass.colorStoreActions[0] != m_ActiveColorStoreActions[0] || renderPass.depthStoreAction != m_ActiveDepthStoreAction)
                    {
                        SetRenderTarget(cmd, passColorAttachment.handle, passDepthAttachment.handle, finalClearFlag, finalClearColor, renderPass.colorStoreActions[0], renderPass.depthStoreAction);
                    }
                }
            }

#pragma warning restore 0618
        }

        //单个相机渲染事件Cull之前执行的初始化操作
        internal void Clear(CameraRenderType cameraType)
        {
            m_ActiveColorAttachments[0] = BuiltinRenderTextureType.CameraTarget;
            for (int i = 1; i < m_ActiveColorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = 0;

            m_ActiveDepthAttachment = BuiltinRenderTextureType.CameraTarget;

            m_FirstTimeCameraColorTargetIsBound = cameraType == CameraRenderType.Base;
            m_FirstTimeCameraDepthTargetIsBound = true;

            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { fallback = BuiltinRenderTextureType.CameraTarget };
            m_CameraDepthTarget = new RTHandleRenderTargetIdentifierCompat { fallback = BuiltinRenderTextureType.CameraTarget };
        }

        public void EnqueuePass(SekiaRendererPass pass)
        {
            m_ActiveRenderPassQueue.Add(pass);
        }
    }
}
