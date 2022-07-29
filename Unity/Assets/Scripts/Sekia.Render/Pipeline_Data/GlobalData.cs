
using UnityEngine;
using UnityEngine.Rendering;
using System;
using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace Sekia
{
    public partial class Define
    {
#if UNITY_EDITOR
        public static bool _IsEditor = true;
#else
        public static bool _IsEditor = false;
#endif
    }

    public enum RT_Type
    {
        CameraTarget, //BackBuffer
        ColorCopy, //CopyRT
        DepthCopy,
        ColorMain, //中间RT 在一帧中不会变
        DepthMain,
        PP_Lut,
    }

    public class GlobalData
    {
        public static GlobalData Instance = new GlobalData();

        #region 定义RT
        public RTHandle GetRT(RT_Type type)
        {
            switch (type)
            {
                case RT_Type.CameraTarget:
                    return k_CameraTarget;                  //backBuffer
                case RT_Type.ColorCopy:
                    return m_OpaqueColor;                   //复制Color
                case RT_Type.DepthCopy:
                    return m_DepthTexture;                  //复制Depth
                case RT_Type.ColorMain:
                    return m_ActiveCameraColorAttachment;   //主Color
                case RT_Type.DepthMain:
                    return m_ActiveCameraDepthAttachment;   //主Depth
                case RT_Type.PP_Lut:
                    return colorGradingLut;                 //Lut
            }
            return null;
        }

        //RT同时包含depth和color的情况只可能发生在使用RTHandles.Alloc创建的对象
        //k_CameraTarget.rt == null
        public readonly RTHandle k_CameraTarget = RTHandles.Alloc(BuiltinRenderTextureType.CameraTarget);

        internal SwapBufferSystem m_ColorBufferSystem; //能体现渲染意图的渲染目标 双颜色buffer交替
        public RTHandle m_CameraDepthAttachment;
        public RTHandle m_ActiveCameraColorAttachment; //根据pass执行顺序指定的临时渲染目标
        public RTHandle m_ActiveCameraDepthAttachment;
        public RTHandle m_OpaqueColor; //copy产生颜色和深度
        public RTHandle m_DepthTexture;

        public RTHandle colorGradingLut;
        public RTHandle m_MotionVectorColor;
        public RTHandle m_MotionVectorDepth;
        public RTHandle m_NormalsTexture;
        #endregion

        #region 定义性能分析采样器
        public static class Profiling
        {
            public static readonly ProfilingSampler beginContextRendering = new ProfilingSampler("Pipeline.BeginContextRendering");
            public static readonly ProfilingSampler endContextRendering = new ProfilingSampler("Pipeline.EndContextRendering");
            public static readonly ProfilingSampler beginCameraRendering = new ProfilingSampler("Pipeline.BeginCameraRendering");
            public static readonly ProfilingSampler endCameraRendering = new ProfilingSampler("Pipeline.EndCameraRendering");

            public static readonly ProfilingSampler initializeCameraData = new ProfilingSampler("SekiaPipeline.InitializeCameraData");
            public static readonly ProfilingSampler initializeStackedCameraData = new ProfilingSampler("SekiaPipeline.InitializeStackedCameraData");
            public static readonly ProfilingSampler initializeAdditionalCameraData = new ProfilingSampler("SekiaPipeline.InitializeAdditionalCameraData");
            public static readonly ProfilingSampler initializeRenderingData = new ProfilingSampler("SekiaPipeline.InitializeRenderingData");
            public static readonly ProfilingSampler initializeShadowData = new ProfilingSampler("SekiaPipeline.InitializeShadowData");
            public static readonly ProfilingSampler initializeLightData = new ProfilingSampler("SekiaPipeline.InitializeLightData");
            public static readonly ProfilingSampler getPerObjectLightFlags = new ProfilingSampler("SekiaPipeline.GetPerObjectLightFlags");
            public static readonly ProfilingSampler getMainLightIndex = new ProfilingSampler("SekiaPipeline.GetMainLightIndex");
            public static readonly ProfilingSampler setupPerFrameShaderConstants = new ProfilingSampler("SekiaPipeline.SetupPerFrameShaderConstants");

            public static readonly ProfilingSampler setupCullingParameters = new ProfilingSampler("ScriptableRenderer.SetupCullingParameters");
            public static readonly ProfilingSampler setup = new ProfilingSampler("ScriptableRenderer.Setup");

            public static readonly ProfilingSampler submit = new ProfilingSampler($"ScriptableRenderContext.Submit");

            public static readonly ProfilingSampler createCameraRenderTarget = new ProfilingSampler("SekiaRenderer.CreateCameraRenderTarget");
            public static readonly ProfilingSampler addRenderPasses = new ProfilingSampler("SekiaRenderer.AddRenderPasses");
            public static readonly ProfilingSampler setupRenderPasses = new ProfilingSampler("SekiaRenderer.SetupRenderPasses");
            public static readonly ProfilingSampler internalStartRendering = new ProfilingSampler("SekiaRenderer.InternalStartRendering");
            public static readonly ProfilingSampler clearRenderingState = new ProfilingSampler("SekiaRenderer.ClearRenderingState");
            public static readonly ProfilingSampler setupFrameData = new ProfilingSampler("SekiaRenderer.SetupFrameData");
            public static readonly ProfilingSampler setupLights = new ProfilingSampler("SekiaRenderer.SetupLights");
            public static readonly ProfilingSampler setupCamera = new ProfilingSampler("SekiaRenderer.SetupCamera");
            public static readonly ProfilingSampler configure = new ProfilingSampler("SekiaRenderer.Configure");
            public static readonly ProfilingSampler internalFinishRendering = new ProfilingSampler("SekiaRenderer.InternalFinishRendering");
            public static readonly ProfilingSampler setPerCameraShaderVariables = new ProfilingSampler("SekiaRenderer.SetPerCameraShaderVariables");
            public static readonly ProfilingSampler drawGizmos = new ProfilingSampler("SekiaRenderer.DrawGizmos");

            private static Dictionary<int, ProfilingSampler> s_HashSamplerCache = new Dictionary<int, ProfilingSampler>();
            public static readonly ProfilingSampler unknownSampler = new ProfilingSampler("Unknown");

            public static ProfilingSampler TryGetOrAddCameraSampler(Camera camera)
            {
                if (Define._IsEditor)
                {
                    ProfilingSampler ps;
                    int cameraId = camera.GetHashCode();
                    bool exists = s_HashSamplerCache.TryGetValue(cameraId, out ps);
                    if (!exists)
                    {
                        ps = new ProfilingSampler($"Camera:{camera.name}");
                        s_HashSamplerCache.Add(cameraId, ps);
                    }
                    return ps;
                }
                else
                    return unknownSampler;
            }
        }
        #endregion

        #region 渲染设置
        public Action OnDispose;

        internal ForwardData m_ForwardLights;
        internal DeferredData m_DeferredLights;
        public RenderingMode m_RenderingMode; //用户设置 Forward | Forward+ | Deferred
        public bool m_Clustering; //Forward+ 与延迟渲染无关
        public bool useRenderPassEnabled; //功能开启状态
        #endregion

        #region 材质球
        public Material m_BlitMaterial = null;
        public Material m_CopyDepthMaterial = null;
        public Material m_SamplingMaterial = null;
        public Material m_StencilDeferredMaterial = null;
        public Material m_CameraMotionVecMaterial = null;
        public Material m_ObjectMotionVecMaterial = null;
        public StencilState m_DefaultStencilState;
        #endregion

        #region 系统状态
        public GraphicsDeviceType graphicsDeviceType;
        public bool IsGLESDevice;
        public bool IsGLDevice;
        #endregion
    }

    public struct CameraData
    {
        // Internal camera data as we are not yet sure how to expose View in stereo context.
        // We might change this API soon.
        Matrix4x4 m_ViewMatrix;
        Matrix4x4 m_ProjectionMatrix;

        internal void SetViewAndProjectionMatrix(Matrix4x4 viewMatrix, Matrix4x4 projectionMatrix)
        {
            m_ViewMatrix = viewMatrix;
            m_ProjectionMatrix = projectionMatrix;
        }

        /// <summary>
        /// Returns the camera view matrix.
        /// </summary>
        /// <param name="viewIndex"> View index in case of stereo rendering. By default <c>viewIndex</c> is set to 0. </param>
        /// <returns> The camera view matrix. </returns>
        public Matrix4x4 GetViewMatrix(int viewIndex = 0)
        {
#if ENABLE_VR && ENABLE_XR_MODULE
            if (xr.enabled)
                return xr.GetViewMatrix(viewIndex);
#endif
            return m_ViewMatrix;
        }

        /// <summary>
        /// Returns the camera projection matrix.
        /// </summary>
        /// <param name="viewIndex"> View index in case of stereo rendering. By default <c>viewIndex</c> is set to 0. </param>
        /// <returns> The camera projection matrix. </returns>
        public Matrix4x4 GetProjectionMatrix(int viewIndex = 0)
        {
#if ENABLE_VR && ENABLE_XR_MODULE
            if (xr.enabled)
                return xr.GetProjMatrix(viewIndex);
#endif
            return m_ProjectionMatrix;
        }

        /// <summary>
        /// Returns the camera GPU projection matrix. This contains platform specific changes to handle y-flip and reverse z.
        /// Similar to <c>GL.GetGPUProjectionMatrix</c> but queries URP internal state to know if the pipeline is rendering to render texture.
        /// For more info on platform differences regarding camera projection check: https://docs.unity3d.com/Manual/SL-PlatformDifferences.html
        /// </summary>
        /// <param name="viewIndex"> View index in case of stereo rendering. By default <c>viewIndex</c> is set to 0. </param>
        /// <seealso cref="GL.GetGPUProjectionMatrix(Matrix4x4, bool)"/>
        /// <returns></returns>
        public Matrix4x4 GetGPUProjectionMatrix(int viewIndex = 0)
        {
            return GL.GetGPUProjectionMatrix(GetProjectionMatrix(viewIndex), IsCameraProjectionMatrixFlipped());
        }

        internal Matrix4x4 GetGPUProjectionMatrix(bool renderIntoTexture, int viewIndex = 0)
        {
            return GL.GetGPUProjectionMatrix(GetProjectionMatrix(viewIndex), renderIntoTexture);
        }

        /// <summary>
        /// The camera component.
        /// </summary>
        public Camera camera;

        /// <summary>
        /// The camera render type used for camera stacking.
        /// <see cref="CameraRenderType"/>
        /// </summary>
        public CameraRenderType renderType;

        /// <summary>
        /// Controls the final target texture for a camera. If null camera will resolve rendering to screen.
        /// </summary>
        public RenderTexture targetTexture;

        /// <summary>
        /// Render texture settings used to create intermediate camera textures for rendering.
        /// </summary>
        public RenderTextureDescriptor cameraTargetDescriptor;
        internal Rect pixelRect;
        internal bool useScreenCoordOverride;
        internal Vector4 screenSizeOverride;
        internal Vector4 screenCoordScaleBias;
        internal int pixelWidth;
        internal int pixelHeight;
        internal float aspectRatio;

        /// <summary>
        /// Render scale to apply when creating camera textures.
        /// </summary>
        public float renderScale;
        internal ImageScalingMode imageScalingMode;
        internal ImageUpscalingFilter upscalingFilter;
        internal bool fsrOverrideSharpness;
        internal float fsrSharpness;
        internal HDRColorBufferPrecision hdrColorBufferPrecision;

        /// <summary>
        /// True if this camera should clear depth buffer. This setting only applies to cameras of type <c>CameraRenderType.Overlay</c>
        /// <seealso cref="CameraRenderType"/>
        /// </summary>
        public bool clearDepth;

        /// <summary>
        /// The camera type.
        /// <seealso cref="UnityEngine.CameraType"/>
        /// </summary>
        public CameraType cameraType;

        /// <summary>
        /// True if this camera is drawing to a viewport that maps to the entire screen.
        /// </summary>
        public bool isDefaultViewport;

        /// <summary>
        /// True if this camera should render to high dynamic range color targets.
        /// </summary>
        public bool isHdrEnabled;

        /// <summary>
        /// True if this camera requires to write _CameraDepthTexture.
        /// </summary>
        public bool requiresDepthTexture;

        /// <summary>
        /// True if this camera requires to copy camera color texture to _CameraOpaqueTexture.
        /// </summary>
        public bool requiresOpaqueTexture;

        /// <summary>
        /// Returns true if post processing passes require depth texture.
        /// </summary>
        public bool postProcessingRequiresDepthTexture;

        public bool xrRendering;
        internal bool requireSrgbConversion
        {
            get
            {
#if ENABLE_VR && ENABLE_XR_MODULE
                if (xr.enabled)
                    return !xr.renderTargetDesc.sRGB && (QualitySettings.activeColorSpace == ColorSpace.Linear);
#endif

                return targetTexture == null && Display.main.requiresSrgbBlitToBackbuffer;
            }
        }

        /// <summary>
        /// True if the camera rendering is for the scene window in the editor.
        /// </summary>
        public bool isSceneViewCamera => cameraType == CameraType.SceneView;

        /// <summary>
        /// True if the camera rendering is for the preview window in the editor.
        /// </summary>
        public bool isPreviewCamera => cameraType == CameraType.Preview;

        internal bool isRenderPassSupportedCamera => (cameraType == CameraType.Game || cameraType == CameraType.Reflection);

        /// <summary>
        /// True if the camera device projection matrix is flipped. This happens when the pipeline is rendering
        /// to a render texture in non OpenGL platforms. If you are doing a custom Blit pass to copy camera textures
        /// (_CameraColorTexture, _CameraDepthAttachment) you need to check this flag to know if you should flip the
        /// matrix when rendering with for cmd.Draw* and reading from camera textures.
        /// <returns> True if the camera device projection matrix is flipped. </returns>
        /// </summary>
        public bool IsCameraProjectionMatrixFlipped()
        {
            // Users only have access to CameraData on URP rendering scope. The current renderer should never be null.
            var renderer = ScriptableRenderer.current;
            Debug.Assert(renderer != null, "IsCameraProjectionMatrixFlipped is being called outside camera rendering scope.");

            if (renderer != null)
            {
#pragma warning disable 0618 // Obsolete usage: Backwards compatibility for custom pipelines that aren't using RTHandles
                var targetId = renderer.cameraColorTargetHandle?.nameID ?? renderer.cameraColorTarget;
#pragma warning restore 0618
                bool renderingToBackBufferTarget = targetId == BuiltinRenderTextureType.CameraTarget;
#if ENABLE_VR && ENABLE_XR_MODULE
                if (xr.enabled)
                    renderingToBackBufferTarget |= targetId == new RenderTargetIdentifier(xr.renderTarget, 0, CubemapFace.Unknown, 0);
#endif
                bool renderingToTexture = !renderingToBackBufferTarget || targetTexture != null;
                return SystemInfo.graphicsUVStartsAtTop && renderingToTexture;
            }

            return true;
        }

        public bool IsRenderTargetProjectionMatrixFlipped(RTHandle color, RTHandle depth = null)
        {

#pragma warning disable 0618 // Obsolete usage: Backwards compatibility for custom pipelines that aren't using RTHandles
            var targetId = color?.nameID ?? depth?.nameID;
#pragma warning restore 0618
            bool renderingToBackBufferTarget = targetId == BuiltinRenderTextureType.CameraTarget;
#if ENABLE_VR && ENABLE_XR_MODULE
            if (xr.enabled)
                renderingToBackBufferTarget |= targetId == xr.renderTarget;
#endif
            bool renderingToTexture = !renderingToBackBufferTarget || targetTexture != null;
            return SystemInfo.graphicsUVStartsAtTop && renderingToTexture;
        }

        /// <summary>
        /// The sorting criteria used when drawing opaque objects by the internal URP render passes.
        /// When a GPU supports hidden surface removal, URP will rely on that information to avoid sorting opaque objects front to back and
        /// benefit for more optimal static batching.
        /// </summary>
        /// <seealso cref="SortingCriteria"/>
        public SortingCriteria defaultOpaqueSortFlags;

        /// <summary>
        /// Maximum shadow distance visible to the camera. When set to zero shadows will be disable for that camera.
        /// </summary>
        public float maxShadowDistance;

        /// <summary>
        /// True if post-processing is enabled for this camera.
        /// </summary>
        public bool postProcessEnabled;

        /// <summary>
        /// Provides set actions to the renderer to be triggered at the end of the render loop for camera capture.
        /// </summary>
        public IEnumerator<Action<RenderTargetIdentifier, CommandBuffer>> captureActions;

        /// <summary>
        /// The camera volume layer mask.
        /// </summary>
        public LayerMask volumeLayerMask;

        /// <summary>
        /// The camera volume trigger.
        /// </summary>
        public Transform volumeTrigger;

        /// <summary>
        /// If set to true, the integrated post-processing stack will replace any NaNs generated by render passes prior to post-processing with black/zero.
        /// Enabling this option will cause a noticeable performance impact. It should be used while in development mode to identify NaN issues.
        /// </summary>
        public bool isStopNaNEnabled;

        /// <summary>
        /// If set to true a final post-processing pass will be applied to apply dithering.
        /// This can be combined with post-processing antialiasing.
        /// <seealso cref="antialiasing"/>
        /// </summary>
        public bool isDitheringEnabled;

        /// <summary>
        /// Controls the anti-alising mode used by the integrated post-processing stack.
        /// When any other value other than <c>AntialiasingMode.None</c> is chosen, a final post-processing pass will be applied to apply anti-aliasing.
        /// This pass can be combined with dithering.
        /// <see cref="AntialiasingMode"/>
        /// <seealso cref="isDitheringEnabled"/>
        /// </summary>
        public AntialiasingMode antialiasing;

        /// <summary>
        /// Controls the anti-alising quality of the anti-aliasing mode.
        /// <see cref="antialiasingQuality"/>
        /// <seealso cref="AntialiasingMode"/>
        /// </summary>
        public AntialiasingQuality antialiasingQuality;
        public SekiaRenderer renderer;

        /// <summary>
        /// True if this camera is resolving rendering to the final camera render target.
        /// When rendering a stack of cameras only the last camera in the stack will resolve to camera target.
        /// </summary>
        public bool resolveFinalTarget;

        /// <summary>
        /// Camera position in world space.
        /// </summary>
        public Vector3 worldSpaceCameraPos;

        /// <summary>
        /// Final background color in the active color space.
        /// </summary>
        public Color backgroundColor;

        /// Camera at the top of the overlay camera stack
        /// </summary>
        public Camera baseCamera;
    }

    public struct RenderingData
    {
        internal CommandBuffer commandBuffer;

        /// <summary>
        /// Returns culling results that exposes handles to visible objects, lights and probes.
        /// You can use this to draw objects with <c>ScriptableRenderContext.DrawRenderers</c>
        /// <see cref="CullingResults"/>
        /// <seealso cref="ScriptableRenderContext"/>
        /// </summary>
        public CullingResults cullResults;

        /// <summary>
        /// Holds several rendering settings related to camera.
        /// <see cref="CameraData"/>
        /// </summary>
        public CameraData cameraData;

        /// <summary>
        /// Holds several rendering settings related to lights.
        /// <see cref="LightData"/>
        /// </summary>
        public LightData lightData;

        /// <summary>
        /// Holds several rendering settings related to shadows.
        /// <see cref="ShadowData"/>
        /// </summary>
        public ShadowData shadowData;

        /// <summary>
        /// Holds several rendering settings and resources related to the integrated post-processing stack.
        /// <see cref="PostProcessData"/>
        /// </summary>
        public PostProcessingData postProcessingData;

        /// <summary>
        /// True if the pipeline supports dynamic batching.
        /// This settings doesn't apply when drawing shadow casters. Dynamic batching is always disabled when drawing shadow casters.
        /// </summary>
        public bool supportsDynamicBatching;

        /// <summary>
        /// Holds per-object data that are requested when drawing
        /// <see cref="PerObjectData"/>
        /// </summary>
        public PerObjectData perObjectData;

        /// <summary>
        /// True if post-processing effect is enabled while rendering the camera stack.
        /// </summary>
        public bool postProcessingEnabled;
    }
}
