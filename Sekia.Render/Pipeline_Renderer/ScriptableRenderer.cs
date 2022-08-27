using System;
using System.Diagnostics;
using System.Collections.Generic;
using Unity.Collections;
using UnityEditor;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Profiling;
using UnityEngine.Rendering;
using UnityEngine;
using Debug = UnityEngine.Debug;
using UnityEngine.Assertions;

namespace Sekia
{
    public abstract partial class ScriptableRenderer : IDisposable
    {
        static readonly ProfilingSampler addRenderPasses = new ProfilingSampler("AddRenderPasses");
        static readonly ProfilingSampler onCameraSetup = new ProfilingSampler("OnCameraSetup");
        static readonly ProfilingSampler configure = new ProfilingSampler("RenderPassConfigure");
        private static partial class Profiling
        {
            private const string k_Name = nameof(ScriptableRenderer);
            public static readonly ProfilingSampler setPerCameraShaderVariables = new ProfilingSampler($"{k_Name}.{nameof(SetPerCameraShaderVariables)}");

            public static readonly ProfilingSampler setupLights = new ProfilingSampler($"{k_Name}.{nameof(SetupLights)}");
            public static readonly ProfilingSampler internalFinishRendering = new ProfilingSampler($"{k_Name}.{nameof(InternalFinishRendering)}");
            public static readonly ProfilingSampler drawGizmos = new ProfilingSampler($"{nameof(DrawGizmos)}");

            public static class RenderBlock
            {
                private const string k_Name = nameof(RenderPassBlock);
                public static readonly ProfilingSampler beforeRendering = new ProfilingSampler($"{k_Name}.{nameof(RenderPassBlock.BeforeRendering)}");
                public static readonly ProfilingSampler mainRenderingOpaque = new ProfilingSampler($"{k_Name}.{nameof(RenderPassBlock.MainRenderingOpaque)}");
                public static readonly ProfilingSampler mainRenderingTransparent = new ProfilingSampler($"{k_Name}.{nameof(RenderPassBlock.MainRenderingTransparent)}");
                public static readonly ProfilingSampler afterRendering = new ProfilingSampler($"{k_Name}.{nameof(RenderPassBlock.AfterRendering)}");
            }
        }

        /// <summary>
        /// Override to provide a custom profiling name
        /// </summary>
        protected ProfilingSampler profilingExecute { get; set; }

        /// <summary>
        /// The renderer we are currently rendering with, for low-level render control only.
        /// <c>current</c> is null outside rendering scope.
        /// Similar to https://docs.unity3d.com/ScriptReference/Camera-current.html
        /// </summary>
        internal static ScriptableRenderer current = null;

        /// <summary>
        /// Set camera matrices. This method will set <c>UNITY_MATRIX_V</c>, <c>UNITY_MATRIX_P</c>, <c>UNITY_MATRIX_VP</c> to camera matrices.
        /// Additionally this will also set <c>unity_CameraProjection</c> and <c>unity_CameraProjection</c>.
        /// If <c>setInverseMatrices</c> is set to true this function will also set <c>UNITY_MATRIX_I_V</c> and <c>UNITY_MATRIX_I_VP</c>.
        /// This function has no effect when rendering in stereo. When in stereo rendering you cannot override camera matrices.
        /// If you need to set general purpose view and projection matrices call <see cref="SetViewAndProjectionMatrices(CommandBuffer, Matrix4x4, Matrix4x4, bool)"/> instead.
        /// </summary>
        /// <param name="cmd">CommandBuffer to submit data to GPU.</param>
        /// <param name="cameraData">CameraData containing camera matrices information.</param>
        /// <param name="setInverseMatrices">Set this to true if you also need to set inverse camera matrices.</param>
        public static void SetCameraMatrices(CommandBuffer cmd, ref CameraData cameraData, bool setInverseMatrices)
        {
            Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
            Matrix4x4 projectionMatrix = cameraData.GetProjectionMatrix();

            // TODO: Investigate why SetViewAndProjectionMatrices is causing y-flip / winding order issue
            // for now using cmd.SetViewProjecionMatrices
            //SetViewAndProjectionMatrices(cmd, viewMatrix, cameraData.GetDeviceProjectionMatrix(), setInverseMatrices);
            cmd.SetViewProjectionMatrices(viewMatrix, projectionMatrix);

            if (setInverseMatrices)
            {
                Matrix4x4 gpuProjectionMatrix = cameraData.GetGPUProjectionMatrix();
                Matrix4x4 viewAndProjectionMatrix = gpuProjectionMatrix * viewMatrix;
                Matrix4x4 inverseViewMatrix = Matrix4x4.Inverse(viewMatrix);
                Matrix4x4 inverseProjectionMatrix = Matrix4x4.Inverse(gpuProjectionMatrix);
                Matrix4x4 inverseViewProjection = inverseViewMatrix * inverseProjectionMatrix;

                // There's an inconsistency in handedness between unity_matrixV and unity_WorldToCamera
                // Unity changes the handedness of unity_WorldToCamera (see Camera::CalculateMatrixShaderProps)
                // we will also change it here to avoid breaking existing shaders. (case 1257518)
                Matrix4x4 worldToCameraMatrix = Matrix4x4.Scale(new Vector3(1.0f, 1.0f, -1.0f)) * viewMatrix;
                Matrix4x4 cameraToWorldMatrix = worldToCameraMatrix.inverse;
                cmd.SetGlobalMatrix(ShaderPropertyId.worldToCameraMatrix, worldToCameraMatrix);
                cmd.SetGlobalMatrix(ShaderPropertyId.cameraToWorldMatrix, cameraToWorldMatrix);

                cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewMatrix, inverseViewMatrix);
                cmd.SetGlobalMatrix(ShaderPropertyId.inverseProjectionMatrix, inverseProjectionMatrix);
                cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewAndProjectionMatrix, inverseViewProjection);
            }

            // TODO: Add SetPerCameraClippingPlaneProperties here once we are sure it correctly behaves in overlay camera for some time
        }

        /// <summary>
        /// Set camera and screen shader variables as described in https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
        /// </summary>
        /// <param name="cmd">CommandBuffer to submit data to GPU.</param>
        /// <param name="cameraData">CameraData containing camera matrices information.</param>
        void SetPerCameraShaderVariables(CommandBuffer cmd, ref CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, Profiling.setPerCameraShaderVariables);

            Camera camera = cameraData.camera;

            Rect pixelRect = cameraData.pixelRect;
            float renderScale = cameraData.isSceneViewCamera ? 1f : cameraData.renderScale;
            float scaledCameraWidth = (float)pixelRect.width * renderScale;
            float scaledCameraHeight = (float)pixelRect.height * renderScale;
            float cameraWidth = (float)pixelRect.width;
            float cameraHeight = (float)pixelRect.height;

            if (camera.allowDynamicResolution)
            {
                scaledCameraWidth *= ScalableBufferManager.widthScaleFactor;
                scaledCameraHeight *= ScalableBufferManager.heightScaleFactor;
            }

            float near = camera.nearClipPlane;
            float far = camera.farClipPlane;
            float invNear = Mathf.Approximately(near, 0.0f) ? 0.0f : 1.0f / near;
            float invFar = Mathf.Approximately(far, 0.0f) ? 0.0f : 1.0f / far;
            float isOrthographic = camera.orthographic ? 1.0f : 0.0f;

            // From http://www.humus.name/temp/Linearize%20depth.txt
            // But as depth component textures on OpenGL always return in 0..1 range (as in D3D), we have to use
            // the same constants for both D3D and OpenGL here.
            // OpenGL would be this:
            // zc0 = (1.0 - far / near) / 2.0;
            // zc1 = (1.0 + far / near) / 2.0;
            // D3D is this:
            float zc0 = 1.0f - far * invNear;
            float zc1 = far * invNear;

            Vector4 zBufferParams = new Vector4(zc0, zc1, zc0 * invFar, zc1 * invFar);

            if (SystemInfo.usesReversedZBuffer)
            {
                zBufferParams.y += zBufferParams.x;
                zBufferParams.x = -zBufferParams.x;
                zBufferParams.w += zBufferParams.z;
                zBufferParams.z = -zBufferParams.z;
            }

            // Projection flip sign logic is very deep in GfxDevice::SetInvertProjectionMatrix
            // This setup is tailored especially for overlay camera game view
            // For other scenarios this will be overwritten correctly by SetupCameraProperties
            float projectionFlipSign = cameraData.IsCameraProjectionMatrixFlipped() ? -1.0f : 1.0f;
            Vector4 projectionParams = new Vector4(projectionFlipSign, near, far, 1.0f * invFar);
            cmd.SetGlobalVector(ShaderPropertyId.projectionParams, projectionParams);

            Vector4 orthoParams = new Vector4(camera.orthographicSize * cameraData.aspectRatio, camera.orthographicSize, 0.0f, isOrthographic);

            // Camera and Screen variables as described in https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
            cmd.SetGlobalVector(ShaderPropertyId.worldSpaceCameraPos, cameraData.worldSpaceCameraPos);
            cmd.SetGlobalVector(ShaderPropertyId.screenParams, new Vector4(cameraWidth, cameraHeight, 1.0f + 1.0f / cameraWidth, 1.0f + 1.0f / cameraHeight));
            cmd.SetGlobalVector(ShaderPropertyId.scaledScreenParams, new Vector4(scaledCameraWidth, scaledCameraHeight, 1.0f + 1.0f / scaledCameraWidth, 1.0f + 1.0f / scaledCameraHeight));
            cmd.SetGlobalVector(ShaderPropertyId.zBufferParams, zBufferParams);
            cmd.SetGlobalVector(ShaderPropertyId.orthoParams, orthoParams);

            cmd.SetGlobalVector(ShaderPropertyId.screenSize, new Vector4(cameraWidth, cameraHeight, 1.0f / cameraWidth, 1.0f / cameraHeight));

            //Set per camera matrices.
            SetCameraMatrices(cmd, ref cameraData, true);
        }

        /// <summary>
        /// Set the Camera billboard properties.
        /// </summary>
        /// <param name="cmd">CommandBuffer to submit data to GPU.</param>
        /// <param name="cameraData">CameraData containing camera matrices information.</param>
        void SetPerCameraBillboardProperties(CommandBuffer cmd, ref CameraData cameraData)
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

        private void SetPerCameraClippingPlaneProperties(CommandBuffer cmd, in CameraData cameraData)
        {
            Matrix4x4 projectionMatrix = cameraData.GetGPUProjectionMatrix();
            Matrix4x4 viewMatrix = cameraData.GetViewMatrix();

            Matrix4x4 viewProj = CoreMatrixUtils.MultiplyProjectionMatrix(projectionMatrix, viewMatrix, cameraData.camera.orthographic);
            Plane[] planes = s_Planes;
            GeometryUtility.CalculateFrustumPlanes(viewProj, planes);

            Vector4[] cameraWorldClipPlanes = s_VectorPlanes;
            for (int i = 0; i < planes.Length; ++i)
                cameraWorldClipPlanes[i] = new Vector4(planes[i].normal.x, planes[i].normal.y, planes[i].normal.z, planes[i].distance);

            cmd.SetGlobalVectorArray(ShaderPropertyId.cameraWorldClipPlanes, cameraWorldClipPlanes);
        }

        /// <summary>
        /// Returns the camera color target for this renderer.
        /// It's only valid to call cameraColorTarget in the scope of <c>ScriptableRenderPass</c>.
        /// <seealso cref="ScriptableRenderPass"/>.
        /// </summary>
        public RTHandle cameraColorTargetHandle
        {
            get
            {
                if (!m_IsPipelineExecuting)
                {
                    Debug.LogError("You can only call cameraColorTarget inside the scope of a ScriptableRenderPass. Otherwise the pipeline camera target texture might have not been created or might have already been disposed.");
                    return null;
                }

                return m_CameraColorTarget.handle;
            }
        }


        /// <summary>
        /// Returns the frontbuffer color target. Returns null if not implemented by the renderer.
        /// It's only valid to call GetCameraColorFrontBuffer in the scope of <c>ScriptableRenderPass</c>.
        /// </summary>
        /// <param name="cmd"></param>
        /// <returns></returns>
        virtual internal RTHandle GetCameraColorFrontBuffer()
        {
            return null;
        }


        /// <summary>
        /// Returns the backbuffer color target. Returns null if not implemented by the renderer.
        /// It's only valid to call GetCameraColorBackBuffer in the scope of <c>ScriptableRenderPass</c>.
        /// </summary>
        /// <param name="cmd"></param>
        /// <returns></returns>
        virtual internal RTHandle GetCameraColorBackBuffer()
        {
            return null;
        }

        /// <summary>
        /// Returns the camera depth target for this renderer.
        /// It's only valid to call cameraDepthTarget in the scope of <c>ScriptableRenderPass</c>.
        /// <seealso cref="ScriptableRenderPass"/>.
        /// </summary>
        [Obsolete("Use cameraDepthTargetHandle")]
        public RenderTargetIdentifier cameraDepthTarget
        {
            get
            {
                if (!m_IsPipelineExecuting)
                {
                    Debug.LogError("You can only call cameraDepthTarget inside the scope of a ScriptableRenderPass. Otherwise the pipeline camera target texture might have not been created or might have already been disposed.");
                    return BuiltinRenderTextureType.None;
                }

                return m_CameraDepthTarget.nameID;
            }
        }

        /// <summary>
        /// Returns the camera depth target for this renderer.
        /// It's only valid to call cameraDepthTarget in the scope of <c>ScriptableRenderPass</c>.
        /// <seealso cref="ScriptableRenderPass"/>.
        /// </summary>
        public RTHandle cameraDepthTargetHandle
        {
            get
            {
                if (!m_IsPipelineExecuting)
                {
                    Debug.LogError("You can only call cameraDepthTarget inside the scope of a ScriptableRenderPass. Otherwise the pipeline camera target texture might have not been created or might have already been disposed.");
                    return null;
                }

                return m_CameraDepthTarget.handle;
            }
        }

        /// <summary>
        /// Returns a list of renderer features added to this renderer.
        /// <seealso cref="ScriptableRendererFeature"/>
        /// </summary>
        protected List<ScriptableRendererFeature> rendererFeatures
        {
            get => m_RendererFeatures;
        }

        /// <summary>
        /// Returns a list of render passes scheduled to be executed by this renderer.
        /// <seealso cref="ScriptableRenderPass"/>
        /// </summary>
        protected List<ScriptableRenderPass> activeRenderPassQueue
        {
            get => m_ActiveRenderPassQueue;
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

        private StoreActionsOptimization m_StoreActionsOptimizationSetting = StoreActionsOptimization.Auto;
        private static bool m_UseOptimizedStoreActions = false;

        const int k_RenderPassBlockCount = 4;

        List<ScriptableRenderPass> m_ActiveRenderPassQueue = new List<ScriptableRenderPass>(32);
        List<ScriptableRendererFeature> m_RendererFeatures = new List<ScriptableRendererFeature>(10);

        // Compatibility to support setting targets with RenderTargetIdentifier or RTHandle
        // to be removed once setting RenderTargetIdentifier as target is removed
        internal struct RTHandleRenderTargetIdentifierCompat
        {
            public RTHandle handle;
            public RenderTargetIdentifier fallback;
            public bool useRTHandle => handle != null;
            public RenderTargetIdentifier nameID => useRTHandle ? new RenderTargetIdentifier(handle.nameID, 0, CubemapFace.Unknown, -1) : fallback;
        }

        //主RT
        RTHandleRenderTargetIdentifierCompat m_CameraColorTarget;
        RTHandleRenderTargetIdentifierCompat m_CameraDepthTarget;
        RTHandleRenderTargetIdentifierCompat m_CameraResolveTarget;

        bool m_FirstTimeCameraColorTargetIsBound = true; // flag used to track when m_CameraColorTarget should be cleared (if necessary), as well as other special actions only performed the first time m_CameraColorTarget is bound as a render target
        bool m_FirstTimeCameraDepthTargetIsBound = true; // flag used to track when m_CameraDepthTarget should be cleared (if necessary), the first time m_CameraDepthTarget is bound as a render target

        // The pipeline can only guarantee the camera target texture are valid when the pipeline is executing.
        // Trying to access the camera target before or after might be that the pipeline texture have already been disposed.
        bool m_IsPipelineExecuting = false;

        // Temporary variable to disable custom passes using render pass ( due to it potentially breaking projects with custom render features )
        // To enable it - override SupportsNativeRenderPass method in the feature and return true
        internal bool disableNativeRenderPassInFeatures = false;

        internal bool useRenderPassEnabled = false;
        static RenderTargetIdentifier[] m_ActiveColorAttachments = new RenderTargetIdentifier[] { 0, 0, 0, 0, 0, 0, 0, 0 };
        static RenderTargetIdentifier m_ActiveDepthAttachment;

        private static RenderBufferStoreAction[] m_ActiveColorStoreActions = new RenderBufferStoreAction[]
        {
            RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store,
            RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store
        };

        private static RenderBufferStoreAction m_ActiveDepthStoreAction = RenderBufferStoreAction.Store;

        // CommandBuffer.SetRenderTarget(RenderTargetIdentifier[] colors, RenderTargetIdentifier depth, int mipLevel, CubemapFace cubemapFace, int depthSlice);
        // called from CoreUtils.SetRenderTarget will issue a warning assert from native c++ side if "colors" array contains some invalid RTIDs.
        // To avoid that warning assert we trim the RenderTargetIdentifier[] arrays we pass to CoreUtils.SetRenderTarget.
        // To avoid re-allocating a new array every time we do that, we re-use one of these arrays:
        static RenderTargetIdentifier[][] m_TrimmedColorAttachmentCopies = new RenderTargetIdentifier[][]
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

        internal bool useDepthPriming { get; } = false;

        internal bool stripShadowsOffVariants { get; set; } = false;

        internal bool stripAdditionalLightOffVariants { get; set; } = false;

        public ScriptableRenderer(ScriptableRendererData data)
        {
            profilingExecute = new ProfilingSampler($"{data.name}");

            foreach (var feature in data.rendererFeatures)
            {
                if (feature == null)
                    continue;

                feature.Create();
                m_RendererFeatures.Add(feature);
            }

            ResetNativeRenderPassFrameData();
            useRenderPassEnabled = data.useNativeRenderPass && SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;
            Clear(CameraRenderType.Base);
            m_ActiveRenderPassQueue.Clear();

            if (SekiaPipeline.asset)
                m_StoreActionsOptimizationSetting = SekiaPipeline.asset.storeActionsOptimization;

            m_UseOptimizedStoreActions = m_StoreActionsOptimizationSetting != StoreActionsOptimization.Store;
        }

        public void Dispose()
        {
            // Dispose all renderer features...
            for (int i = 0; i < m_RendererFeatures.Count; ++i)
            {
                if (rendererFeatures[i] == null)
                    continue;

                rendererFeatures[i].Dispose();
            }

            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
        }

        /// <summary>
        /// Configures the camera target.
        /// </summary>
        /// <param name="colorTarget">Camera color target. Pass BuiltinRenderTextureType.CameraTarget if rendering to backbuffer.</param>
        /// <param name="depthTarget">Camera depth target. Pass BuiltinRenderTextureType.CameraTarget if color has depth or rendering to backbuffer.</param>
        [Obsolete("Use RTHandles for colorTarget and depthTarget")]
        public void ConfigureCameraTarget(RenderTargetIdentifier colorTarget, RenderTargetIdentifier depthTarget)
        {
            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { fallback = colorTarget };
            m_CameraDepthTarget = new RTHandleRenderTargetIdentifierCompat { fallback = depthTarget };
        }

        /// <summary>
        /// Configures the camera target.
        /// </summary>
        /// <param name="colorTarget">Camera color target. Pass k_CameraTarget if rendering to backbuffer.</param>
        /// <param name="depthTarget">Camera depth target. Pass k_CameraTarget if color has depth or rendering to backbuffer.</param>
        public void ConfigureCameraTarget(RTHandle colorTarget, RTHandle depthTarget)
        {
            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { handle = colorTarget };
            m_CameraDepthTarget = new RTHandleRenderTargetIdentifierCompat { handle = depthTarget };
        }

        // This should be removed when early camera color target assignment is removed.
        internal void ConfigureCameraColorTarget(RTHandle colorTarget)
        {
            m_CameraColorTarget = new RTHandleRenderTargetIdentifierCompat { handle = colorTarget };
        }

        /// <summary>
        /// Configures the render passes that will execute for this renderer.
        /// This method is called per-camera every frame.
        /// </summary>
        /// <param name="context">Use this render context to issue any draw commands during execution.</param>
        /// <param name="renderingData">Current render state information.</param>
        /// <seealso cref="ScriptableRenderPass"/>
        /// <seealso cref="ScriptableRendererFeature"/>
        public abstract void Setup(ScriptableRenderContext context, ref RenderingData renderingData);

        /// <summary>
        /// Override this method to implement the lighting setup for the renderer. You can use this to
        /// compute and upload light CBUFFER for example.
        /// </summary>
        /// <param name="context">Use this render context to issue any draw commands during execution.</param>
        /// <param name="renderingData">Current render state information.</param>
        public virtual void SetupLights(ScriptableRenderContext context, ref RenderingData renderingData)
        {
        }

        /// <summary>
        /// Override this method to configure the culling parameters for the renderer. You can use this to configure if
        /// lights should be culled per-object or the maximum shadow distance for example.
        /// </summary>
        /// <param name="cullingParameters">Use this to change culling parameters used by the render pipeline.</param>
        /// <param name="cameraData">Current render state information.</param>
        public virtual void SetupCullingParameters(ref ScriptableCullingParameters cullingParameters,
            ref CameraData cameraData)
        {
        }

        /// <summary>
        /// Called upon finishing rendering the camera stack. You can release any resources created by the renderer here.
        /// </summary>
        /// <param name="cmd"></param>
        public virtual void FinishRendering(CommandBuffer cmd)
        {
        }

        /// <summary>
        /// Execute the enqueued render passes. This automatically handles editor and stereo rendering.
        /// </summary>
        /// <param name="context">Use this render context to issue any draw commands during execution.</param>
        /// <param name="renderingData">Current render state information.</param>
        public void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            //将自定义Feature列表提取为待执行的Feature列表
            {
                using var profScope = new ProfilingScope(null, addRenderPasses);
                for (int i = 0; i < rendererFeatures.Count; ++i)
                {
                    if (!rendererFeatures[i].isActive)
                        continue;
                    if (!rendererFeatures[i].SupportsNativeRenderPass())
                        disableNativeRenderPassInFeatures = true;

                    rendererFeatures[i].AddRenderPasses(this, ref renderingData);
                    disableNativeRenderPassInFeatures = false;
                }

                int count = activeRenderPassQueue.Count;
                for (int i = count - 1; i >= 0; i--)
                {
                    if (activeRenderPassQueue[i] == null)
                        activeRenderPassQueue.RemoveAt(i);
                }

                //当存在任何自定义pass时 关闭load/save优化策略
                if (count > 0 && m_StoreActionsOptimizationSetting == StoreActionsOptimization.Auto)
                    m_UseOptimizedStoreActions = false;
            }

            m_IsPipelineExecuting = true;
            ref CameraData cameraData = ref renderingData.cameraData;
            Camera camera = cameraData.camera;

            //执行OnCameraSetup
            {
                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(null, onCameraSetup))
                {
                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                    {
                        m_ActiveRenderPassQueue[i].OnCameraSetup(cmd, ref renderingData);
                    }
                }
                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }

            {
                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(cmd, profilingExecute))
                {
                    //清理全局关键字
                    {
                        cmd.DisableShaderKeyword(ShaderKeywordStrings.MainLightShadows);
                        cmd.DisableShaderKeyword(ShaderKeywordStrings.MainLightShadowCascades);
                        cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightsVertex);
                        cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightsPixel);
                        cmd.DisableShaderKeyword(ShaderKeywordStrings.ClusteredRendering);
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

                    SetupNativeRenderPassFrameData(cameraData, useRenderPassEnabled);

                    using (new ProfilingScope(null, Profiling.setupLights))
                    {
                        SetupLights(context, ref renderingData);
                    }

                    {
                        SetPerCameraShaderVariables(cmd, ref cameraData);
                        if (cameraData.renderType == CameraRenderType.Overlay)
                        {
                            // Set new properties
                            SetPerCameraClippingPlaneProperties(cmd, in cameraData);
                            SetPerCameraBillboardProperties(cmd, ref cameraData);
                        }

#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
                        //Triggers dispatch per camera, all global parameters should have been setup at this stage.
                        UnityEngine.VFX.VFXManager.ProcessCameraCommand(camera, cmd);
#endif
                    }

                    context.ExecuteCommandBuffer(cmd);
                    cmd.Clear();

                    //遍历renderPass
                    foreach (var renderPass in m_ActiveRenderPassQueue)
                    {
                        using (new ProfilingScope(null, configure))
                        {
                            if (IsRenderPassEnabled(renderPass) && cameraData.isRenderPassSupportedCamera)
                                ConfigureNativeRenderPass(cmd, renderPass, cameraData);
                            else
                                renderPass.Configure(cmd, cameraData.cameraTargetDescriptor);

                            SetRenderPassAttachments(cmd, renderPass, ref cameraData);
                        }

                        // Also, we execute the commands recorded at this point to ensure SetRenderTarget is called before RenderPass.Execute
                        context.ExecuteCommandBuffer(cmd);
                        cmd.Clear();

                        if (IsRenderPassEnabled(renderPass) && cameraData.isRenderPassSupportedCamera)
                            ExecuteNativeRenderPass(context, renderPass, cameraData, ref renderingData);
                        else
                            renderPass.Execute(context, ref renderingData);
                    }

                    DrawGizmos(context, camera, GizmoSubset.PreImageEffects);
                    DrawWireOverlay(context, camera);
                    DrawGizmos(context, camera, GizmoSubset.PostImageEffects);
                    InternalFinishRendering(context, cameraData.resolveFinalTarget);

                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                    {
                        m_ActiveRenderPassQueue[i].m_ColorAttachmentIndices.Dispose();
                        m_ActiveRenderPassQueue[i].m_InputAttachmentIndices.Dispose();
                    }
                }

                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }

        }

        /// <summary>
        /// Enqueues a render pass for execution.
        /// </summary>
        /// <param name="pass">Render pass to be enqueued.</param>
        public void EnqueuePass(ScriptableRenderPass pass)
        {
            m_ActiveRenderPassQueue.Add(pass);
            if (disableNativeRenderPassInFeatures)
                pass.useNativeRenderPass = false;
        }

        /// <summary>
        /// Returns a clear flag based on CameraClearFlags.
        /// </summary>
        /// <param name="cameraClearFlags">Camera clear flags.</param>
        /// <returns>A clear flag that tells if color and/or depth should be cleared.</returns>
        protected static ClearFlag GetCameraClearFlag(ref CameraData cameraData)
        {
            var cameraClearFlags = cameraData.camera.clearFlags;

            // Universal RP doesn't support CameraClearFlags.DepthOnly and CameraClearFlags.Nothing.
            // CameraClearFlags.DepthOnly has the same effect of CameraClearFlags.SolidColor
            // CameraClearFlags.Nothing clears Depth on PC/Desktop and in mobile it clears both
            // depth and color.
            // CameraClearFlags.Skybox clears depth only.

            // Implementation details:
            // Camera clear flags are used to initialize the attachments on the first render pass.
            // ClearFlag is used together with Tile Load action to figure out how to clear the camera render target.
            // In Tile Based GPUs ClearFlag.Depth + RenderBufferLoadAction.DontCare becomes DontCare load action.

            // RenderBufferLoadAction.DontCare in PC/Desktop behaves as not clearing screen
            // RenderBufferLoadAction.DontCare in Vulkan/Metal behaves as DontCare load action
            // RenderBufferLoadAction.DontCare in GLES behaves as glInvalidateBuffer

            // Overlay cameras composite on top of previous ones. They don't clear color.
            // For overlay cameras we check if depth should be cleared on not.
            if (cameraData.renderType == CameraRenderType.Overlay)
                return (cameraData.clearDepth) ? ClearFlag.DepthStencil : ClearFlag.None;

            if ((cameraClearFlags == CameraClearFlags.Skybox && RenderSettings.skybox != null) ||
                cameraClearFlags == CameraClearFlags.Nothing)
                return ClearFlag.DepthStencil;

            return ClearFlag.All;
        }

        /// <summary>
        /// Calls <c>OnCull</c> for each feature added to this renderer.
        /// <seealso cref="ScriptableRendererFeature.OnCameraPreCull(ScriptableRenderer, in CameraData)"/>
        /// </summary>
        /// <param name="cameraData">Current render state information.</param>
        internal void OnPreCullRenderPasses(in CameraData cameraData)
        {
            // Add render passes from custom renderer features
            for (int i = 0; i < rendererFeatures.Count; ++i)
            {
                if (!rendererFeatures[i].isActive)
                {
                    continue;
                }
                rendererFeatures[i].OnCameraPreCull(this, in cameraData);
            }
        }

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

        private bool IsRenderPassEnabled(ScriptableRenderPass renderPass)
        {
            return renderPass.useNativeRenderPass && useRenderPassEnabled;
        }

        //逐pass设置RenderTarget
        void SetRenderPassAttachments(CommandBuffer cmd, ScriptableRenderPass renderPass, ref CameraData cameraData)
        {
#pragma warning disable 0618 // Obsolete usage: Using deprecated RenderTargetIdentifiers to ensure backwards compatibility with passes set with RenderTargetIdentifier
            Camera camera = cameraData.camera;
            ClearFlag cameraClearFlag = GetCameraClearFlag(ref cameraData);

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
                        SetRenderTarget(cmd, renderPass.colorAttachments[cameraColorTargetIndex], renderPass.depthAttachment, ClearFlag.Color, cameraData.backgroundColor);

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
                            SetRenderTarget(cmd, nonCameraAttachments, m_CameraDepthTarget.nameID, ClearFlag.Color, renderPass.clearColor);
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
                                SetRenderTarget(cmd, trimmedAttachments, depthAttachment, finalClearFlag, renderPass.clearColor);
                            }
                            else
                                Debug.LogError("必须使用RTHandle");
                        }
                    }
                }
            }
            else
            {
                var passColorAttachment = new RTHandleRenderTargetIdentifierCompat { handle = renderPass.colorAttachmentHandle };
                var passDepthAttachment = new RTHandleRenderTargetIdentifierCompat { handle = renderPass.depthAttachmentHandle };

                //未执行ConfigureTarget的render pass被假定目标为当前主RT
                if (!renderPass.overrideCameraTarget)
                {
                    //在main rendering之前pass没ConfigureTarget的话 不会设置RendderTarget
                    if (renderPass.renderPassEvent < RenderPassEvent.BeforeRenderingPrePasses)
                        return;
                    passColorAttachment = m_CameraColorTarget;
                    passDepthAttachment = m_CameraDepthTarget;
                }

                ClearFlag finalClearFlag = ClearFlag.None; //清除哪个buffer
                Color finalClearColor; //清除色

                //判断是否第一次向主目标绘制
                if (passColorAttachment.nameID == m_CameraColorTarget.nameID && m_FirstTimeCameraColorTargetIsBound)
                {
                    m_FirstTimeCameraColorTargetIsBound = false;
                    //根据相机设置判断是否清理颜色
                    finalClearFlag |= (cameraClearFlag & ClearFlag.Color);
                    finalClearColor = cameraData.backgroundColor;

                    //假设初次对主Color渲染时同时绑定了深度buffer
                    if (m_FirstTimeCameraDepthTargetIsBound)
                    {
                        m_FirstTimeCameraDepthTargetIsBound = false;
                        finalClearFlag |= (cameraClearFlag & ClearFlag.DepthStencil);
                    }
                }
                else
                {
                    //非初次渲染到主颜色RT时 只能清理颜色
                    finalClearFlag |= (renderPass.clearFlag & ClearFlag.Color);
                    finalClearColor = renderPass.clearColor;
                }

                //避免提前清除主深度
                if (m_CameraDepthTarget.nameID != BuiltinRenderTextureType.CameraTarget
                    && (passDepthAttachment.nameID == m_CameraDepthTarget.nameID || passColorAttachment.nameID == m_CameraDepthTarget.nameID)
                    && m_FirstTimeCameraDepthTargetIsBound)
                {
                    m_FirstTimeCameraDepthTargetIsBound = false;
                    finalClearFlag |= (cameraClearFlag & ClearFlag.DepthStencil);
                }
                else
                    finalClearFlag |= (renderPass.clearFlag & ClearFlag.DepthStencil);

                if (IsRenderPassEnabled(renderPass) && cameraData.isRenderPassSupportedCamera)
                {
                    SetNativeRenderPassAttachmentList(renderPass, ref cameraData, passColorAttachment.nameID, passDepthAttachment.nameID, finalClearFlag, finalClearColor);
                }
                else
                {
                    // Only setup render target if current render pass attachments are different from the active ones
                    if (passColorAttachment.nameID != m_ActiveColorAttachments[0]
                        || passDepthAttachment.nameID != m_ActiveDepthAttachment
                        || finalClearFlag != ClearFlag.None
                        || renderPass.colorStoreActions[0] != m_ActiveColorStoreActions[0]
                        || renderPass.depthStoreAction != m_ActiveDepthStoreAction)
                    {
                        SetRenderTarget(cmd, passColorAttachment.handle, passDepthAttachment.handle, finalClearFlag, finalClearColor, renderPass.colorStoreActions[0], renderPass.depthStoreAction);
                    }
                }
            }
#pragma warning restore 0618
        }

        [Obsolete("Use RTHandles for colorAttachment and depthAttachment")]
        internal static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorAttachment, RenderTargetIdentifier depthAttachment, ClearFlag clearFlag, Color clearColor)
        {
            m_ActiveColorAttachments[0] = colorAttachment;
            for (int i = 1; i < m_ActiveColorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = 0;
            m_ActiveDepthAttachment = depthAttachment;

            RenderBufferLoadAction colorLoadAction = ((uint)clearFlag & (uint)ClearFlag.Color) != 0
                ? RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;
            RenderBufferLoadAction depthLoadAction = ((uint)clearFlag & (uint)ClearFlag.Depth) != 0 || ((uint)clearFlag & (uint)ClearFlag.Stencil) != 0
                ? RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;

            m_ActiveColorStoreActions[0] = RenderBufferStoreAction.Store;
            m_ActiveDepthStoreAction = RenderBufferStoreAction.Store;
            for (int i = 1; i < m_ActiveColorStoreActions.Length; ++i)
                m_ActiveColorStoreActions[i] = RenderBufferStoreAction.Store;

            if (depthAttachment == BuiltinRenderTextureType.CameraTarget)
            {
                //colorAttachment同时包含2个buffer
                CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, RenderBufferStoreAction.Store, depthLoadAction, RenderBufferStoreAction.Store, clearFlag, clearColor);
            }
            else
            {
                CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, RenderBufferStoreAction.Store,
                    depthAttachment, depthLoadAction, RenderBufferStoreAction.Store, clearFlag, clearColor);
            }
        }

        internal static void SetRenderTarget(CommandBuffer cmd, RTHandle colorAttachment, RTHandle depthAttachment, ClearFlag clearFlag, Color clearColor,
            RenderBufferStoreAction colorStoreAction = RenderBufferStoreAction.Store,
            RenderBufferStoreAction depthStoreAction = RenderBufferStoreAction.Store)
        {
            m_ActiveColorAttachments[0] = colorAttachment;
            for (int i = 1; i < m_ActiveColorAttachments.Length; ++i)
                m_ActiveColorAttachments[i] = 0;
            m_ActiveDepthAttachment = depthAttachment;


            RenderBufferLoadAction colorLoadAction = ((uint)clearFlag & (uint)ClearFlag.Color) != 0 ?
                RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;
            RenderBufferLoadAction depthLoadAction = ((uint)clearFlag & (uint)ClearFlag.Depth) != 0 ?
                RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load;

            m_ActiveColorStoreActions[0] = colorStoreAction;
            for (int i = 1; i < m_ActiveColorStoreActions.Length; ++i)
                m_ActiveColorStoreActions[i] = RenderBufferStoreAction.Store;
            m_ActiveDepthStoreAction = depthStoreAction;

            // if we shouldn't use optimized store actions then fall back to the conservative safe (un-optimal!) route and just store everything
            if (!m_UseOptimizedStoreActions)
            {
                if (colorStoreAction != RenderBufferStoreAction.StoreAndResolve)
                    colorStoreAction = RenderBufferStoreAction.Store;
                if (depthStoreAction != RenderBufferStoreAction.StoreAndResolve)
                    depthStoreAction = RenderBufferStoreAction.Store;
            }

            //深度RT为CameraTarget时表示取colorAttachment中color和depth buffer作为颜色和深度目标
            if (depthAttachment.nameID == BuiltinRenderTextureType.CameraTarget)
                CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction, clearFlag, clearColor);
            else
                CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction,
                    depthAttachment, depthLoadAction, depthStoreAction, clearFlag, clearColor);
        }

        [Obsolete("Use RTHandles for colorAttachments and depthAttachment")]
        static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorAttachments, RenderTargetIdentifier depthAttachment, ClearFlag clearFlag, Color clearColor)
        {
            m_ActiveColorAttachments = colorAttachments;
            m_ActiveDepthAttachment = depthAttachment;

            CoreUtils.SetRenderTarget(cmd, colorAttachments, depthAttachment, clearFlag, clearColor);
        }

        [Obsolete("Use RTHandle for colorAttachments")]
        static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorAttachments, RTHandle depthAttachment, ClearFlag clearFlag, Color clearColor)
        {
            m_ActiveColorAttachments = colorAttachments;
            m_ActiveDepthAttachment = depthAttachment.nameID;

            CoreUtils.SetRenderTarget(cmd, m_ActiveColorAttachments, depthAttachment, clearFlag, clearColor);
        }

        internal virtual void SwapColorBuffer(CommandBuffer cmd) { }

        [Conditional("UNITY_EDITOR")]
        void DrawGizmos(ScriptableRenderContext context, Camera camera, GizmoSubset gizmoSubset)
        {
#if UNITY_EDITOR
            if (!Handles.ShouldRenderGizmos() || camera.sceneViewFilterMode == Camera.SceneViewFilterMode.ShowFiltered)
                return;

            CommandBuffer cmd = CommandBufferPool.Get();
            using (new ProfilingScope(cmd, Profiling.drawGizmos))
            {
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                context.DrawGizmos(camera, gizmoSubset);
            }

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
#endif
        }

        [Conditional("UNITY_EDITOR")]
        void DrawWireOverlay(ScriptableRenderContext context, Camera camera)
        {
            context.DrawWireOverlay(camera);
        }

        void InternalFinishRendering(ScriptableRenderContext context, bool resolveFinalTarget)
        {
            CommandBuffer cmd = CommandBufferPool.Get();
            using (new ProfilingScope(null, Profiling.internalFinishRendering))
            {
                for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                    m_ActiveRenderPassQueue[i].OnCameraCleanup(cmd);

                // Happens when rendering the last camera in the camera stack.
                if (resolveFinalTarget)
                {
                    for (int i = 0; i < m_ActiveRenderPassQueue.Count; ++i)
                        m_ActiveRenderPassQueue[i].OnFinishCameraStackRendering(cmd);

                    FinishRendering(cmd);

                    // We finished camera stacking and released all intermediate pipeline textures.
                    m_IsPipelineExecuting = false;
                }
                m_ActiveRenderPassQueue.Clear();
            }

            ResetNativeRenderPassFrameData();

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
}
