using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;
using Sekia.Internal;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    /// <summary>
    /// Rendering modes for Universal renderer.
    /// </summary>
    public enum RenderingMode
    {
        /// <summary>Render all objects and lighting in one pass, with a hard limit on the number of lights that can be applied on an object.</summary>
        Forward,
        /// <summary>Render all objects first in a g-buffer pass, then apply all lighting in a separate pass using deferred shading.</summary>
        Deferred
    };

    /// <summary>
    /// 仅支持延迟渲染
    /// </summary>
    public sealed class UniversalRenderer : ScriptableRenderer
    {
        static readonly ProfilingSampler createCameraRenderTarget = new ProfilingSampler("CreateCameraRenderTarget");

        // Actual rendering mode, which may be different (ex: wireframe rendering, hardware not capable of deferred rendering).
        internal RenderingMode renderingModeActual =>
            (GL.wireframe
            || ScriptableRendererFeature.m_DeferredLights == null
            || !ScriptableRendererFeature.m_DeferredLights.IsRuntimeSupportedThisFrame()
            || ScriptableRendererFeature.m_DeferredLights.IsOverlay)
        ? RenderingMode.Forward
        : RenderingMode.Deferred;

        //主目标和临时目标
        internal RenderTargetBufferSystem m_ColorBufferSystem;
        internal RTHandle m_CameraDepthAttachment;

        ForwardLights m_ForwardLights;
        LightCookieManager m_LightCookieManager;

        Material m_StencilDeferredMaterial = null;

        public UniversalRenderer(UniversalRendererData data) : base(data)
        {
            // TODO: should merge shaders with HDRP into core, XR dependency for now.
            // TODO: replace/merge URP blit into core blitter.
            Blitter.Initialize(data.shaders.coreBlitPS, data.shaders.coreBlitColorAndDepthPS);

            m_StencilDeferredMaterial = CoreUtils.CreateEngineMaterial(data.shaders.stencilDeferredPS);

            {
                var settings = LightCookieManager.Settings.GetDefault();
                var asset = SekiaPipeline.asset;
                if (asset)
                {
                    settings.atlas.format = asset.additionalLightsCookieFormat;
                    settings.atlas.resolution = asset.additionalLightsCookieResolution;
                }

                m_LightCookieManager = new LightCookieManager(ref settings);
            }

            this.stripShadowsOffVariants = true;
            this.stripAdditionalLightOffVariants = true;

            ForwardLights.InitParams forwardInitParams;
            forwardInitParams.lightCookieManager = m_LightCookieManager;
            forwardInitParams.clusteredRendering = data.clusteredRendering;
            forwardInitParams.tileSize = (int)data.tileSize;
            m_ForwardLights = new ForwardLights(forwardInitParams);
            useRenderPassEnabled = data.useNativeRenderPass && SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;

            {
                var deferredInitParams = new DeferredLights.InitParams();
                deferredInitParams.stencilDeferredMaterial = m_StencilDeferredMaterial;
                deferredInitParams.lightCookieManager = m_LightCookieManager;
                ScriptableRendererFeature.m_DeferredLights = new DeferredLights(deferredInitParams, useRenderPassEnabled);
                ScriptableRendererFeature.m_DeferredLights.AccurateGbufferNormals = false;
            }

            // RenderTexture format depends on camera and pipeline (HDR, non HDR, etc)
            // Samples (MSAA) depend on camera and pipeline
            m_ColorBufferSystem = new RenderTargetBufferSystem("_CameraColorAttachment");

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

            LensFlareCommonSRP.mergeNeeded = 0;
            LensFlareCommonSRP.maxLensFlareWithOcclusionTemporalSample = 1;
            LensFlareCommonSRP.Initialize();
        }

        /// <inheritdoc />
        protected override void Dispose(bool disposing)
        {
            m_ForwardLights.Cleanup();
            ScriptableRendererFeature.colorGradingLut?.Release();

            m_ColorBufferSystem.Dispose();
            m_CameraDepthAttachment?.Release();

            ScriptableRendererFeature.m_DepthTexture?.Release();
            ScriptableRendererFeature.m_OpaqueColor?.Release();
            ScriptableRendererFeature.m_MotionVectorColor?.Release();
            ScriptableRendererFeature.m_MotionVectorDepth?.Release();

            CoreUtils.Destroy(m_StencilDeferredMaterial);

            Blitter.Cleanup();

            LensFlareCommonSRP.Dispose();

            ScriptableRendererFeature.onDispose?.Invoke();
            ScriptableRendererFeature.onDispose = null;
        }

        public override void Setup(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            m_ForwardLights.ProcessLights(ref renderingData);

            ref CameraData cameraData = ref renderingData.cameraData;
            Camera camera = cameraData.camera;
            RenderTextureDescriptor cameraTargetDescriptor = cameraData.cameraTargetDescriptor;

            if (cameraData.cameraType != CameraType.Game)
                useRenderPassEnabled = false;

            if (ScriptableRendererFeature.m_DeferredLights != null)
            {
                ScriptableRendererFeature.m_DeferredLights.ResolveMixedLightingMode(ref renderingData);
                ScriptableRendererFeature.m_DeferredLights.IsOverlay = cameraData.renderType == CameraRenderType.Overlay;
            }

            RenderPassInputSummary renderPassInputs = GetRenderPassInputs(ref renderingData);

            //初始化主目标RT和临时目标RT
            if (cameraData.renderType == CameraRenderType.Base)
            {
                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(null, createCameraRenderTarget))
                {
                    if (m_ColorBufferSystem.PeekBackBuffer() == null || m_ColorBufferSystem.PeekBackBuffer().nameID != BuiltinRenderTextureType.CameraTarget)
                    {
                        var colorDescriptor = cameraTargetDescriptor;
                        colorDescriptor.useMipMap = false;
                        colorDescriptor.autoGenerateMips = false;
                        colorDescriptor.depthBufferBits = 0;
                        m_ColorBufferSystem.SetCameraSettings(colorDescriptor, FilterMode.Bilinear);
                        ScriptableRendererFeature.m_ActiveCameraColorAttachment = m_ColorBufferSystem.GetBackBuffer();
                        ConfigureCameraColorTarget(ScriptableRendererFeature.m_ActiveCameraColorAttachment);
                        cmd.SetGlobalTexture("_CameraColorTexture", ScriptableRendererFeature.m_ActiveCameraColorAttachment.nameID);
                    }

                    if (m_CameraDepthAttachment == null || m_CameraDepthAttachment.nameID != BuiltinRenderTextureType.CameraTarget)
                    {
                        var depthDescriptor = cameraTargetDescriptor;
                        depthDescriptor.useMipMap = false;
                        depthDescriptor.autoGenerateMips = false;
                        depthDescriptor.bindMS = false;
                        depthDescriptor.graphicsFormat = GraphicsFormat.None;
                        depthDescriptor.depthStencilFormat = GraphicsFormat.D32_SFloat_S8_UInt;
                        RenderingUtils.ReAllocateIfNeeded(ref m_CameraDepthAttachment, depthDescriptor, FilterMode.Point, TextureWrapMode.Clamp, name: "_CameraDepthAttachment");
                        cmd.SetGlobalTexture(m_CameraDepthAttachment.name, m_CameraDepthAttachment.nameID);
                    }
                }

                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);

                //主颜色|主深度目标
                ScriptableRendererFeature.m_ActiveCameraColorAttachment = m_ColorBufferSystem.PeekBackBuffer();
                ScriptableRendererFeature.m_ActiveCameraDepthAttachment = m_CameraDepthAttachment;
            }
            else
            {
                cameraData.baseCamera.TryGetComponent<SekiaCameraData>(out var baseCameraData);
                var baseRenderer = (UniversalRenderer)baseCameraData.scriptableRenderer;
                m_ColorBufferSystem = baseRenderer.m_ColorBufferSystem;
                ScriptableRendererFeature.m_ActiveCameraColorAttachment = m_ColorBufferSystem.PeekBackBuffer();
            }
            ConfigureCameraTarget(ScriptableRendererFeature.m_ActiveCameraColorAttachment, ScriptableRendererFeature.m_ActiveCameraDepthAttachment);

            if (ScriptableRendererFeature.m_DeferredLights.UseRenderPass &&
                (RenderPassEvent.AfterRenderingGbuffer == renderPassInputs.requiresDepthNormalAtEvent || !useRenderPassEnabled))
                ScriptableRendererFeature.m_DeferredLights.DisableFramebufferFetchInput();
        }

        /// <inheritdoc />
        public override void SetupLights(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            m_ForwardLights.Setup(context, ref renderingData);
            ScriptableRendererFeature.m_DeferredLights.SetupLights(context, ref renderingData);
        }

        /// <inheritdoc />
        public override void SetupCullingParameters(ref ScriptableCullingParameters cullingParameters,
            ref CameraData cameraData)
        {
            // TODO: PerObjectCulling also affect reflection probes. Enabling it for now.
            // if (asset.additionalLightsRenderingMode == LightRenderingMode.Disabled ||
            //     asset.maxAdditionalLightsCount == 0)
            // {
            //     cullingParameters.cullingOptions |= CullingOptions.DisablePerObjectCulling;
            // }

            // We disable shadow casters if both shadow casting modes are turned off
            // or the shadow distance has been turned down to zero
            bool isShadowCastingDisabled = !SekiaPipeline.asset.supportsMainLightShadows && !SekiaPipeline.asset.supportsAdditionalLightShadows;
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
                cullingParameters.maximumVisibleLights = SekiaPipeline.maxVisibleAdditionalLights + 1;
            }
            cullingParameters.shadowDistance = cameraData.maxShadowDistance;

            cullingParameters.conservativeEnclosingSphere = SekiaPipeline.asset.conservativeEnclosingSphere;

            cullingParameters.numIterationsEnclosingSphere = SekiaPipeline.asset.numIterationsEnclosingSphere;
        }

        /// <inheritdoc />
        public override void FinishRendering(CommandBuffer cmd)
        {
            m_ColorBufferSystem.Clear();
            ScriptableRendererFeature.m_ActiveCameraColorAttachment = null;
            ScriptableRendererFeature.m_ActiveCameraDepthAttachment = null;
        }

        private struct RenderPassInputSummary
        {
            internal bool requiresDepthTexture;
            internal bool requiresDepthPrepass;
            internal bool requiresNormalsTexture;
            internal bool requiresColorTexture;
            internal bool requiresMotionVectors;
            internal RenderPassEvent requiresDepthNormalAtEvent;
            internal RenderPassEvent requiresDepthTextureEarliestEvent;
        }

        private RenderPassInputSummary GetRenderPassInputs(ref RenderingData renderingData)
        {
            RenderPassEvent beforeMainRenderingEvent = RenderPassEvent.BeforeRenderingGbuffer;

            RenderPassInputSummary inputSummary = new RenderPassInputSummary();
            inputSummary.requiresDepthNormalAtEvent = RenderPassEvent.BeforeRenderingOpaques;
            inputSummary.requiresDepthTextureEarliestEvent = RenderPassEvent.BeforeRenderingPostProcessing;
            for (int i = 0; i < activeRenderPassQueue.Count; ++i)
            {
                ScriptableRenderPass pass = activeRenderPassQueue[i];
                bool needsDepth = (pass.input & ScriptableRenderPassInput.Depth) != ScriptableRenderPassInput.None;
                bool needsNormals = (pass.input & ScriptableRenderPassInput.Normal) != ScriptableRenderPassInput.None;
                bool needsColor = (pass.input & ScriptableRenderPassInput.Color) != ScriptableRenderPassInput.None;
                bool needsMotion = (pass.input & ScriptableRenderPassInput.Motion) != ScriptableRenderPassInput.None;
                bool eventBeforeMainRendering = pass.renderPassEvent <= beforeMainRenderingEvent;

                inputSummary.requiresDepthTexture |= needsDepth;
                inputSummary.requiresDepthPrepass |= needsNormals || needsDepth && eventBeforeMainRendering;
                inputSummary.requiresNormalsTexture |= needsNormals;
                inputSummary.requiresColorTexture |= needsColor;
                inputSummary.requiresMotionVectors |= needsMotion;
                if (needsDepth)
                    inputSummary.requiresDepthTextureEarliestEvent = (RenderPassEvent)Mathf.Min((int)pass.renderPassEvent, (int)inputSummary.requiresDepthTextureEarliestEvent);
                if (needsNormals || needsDepth)
                    inputSummary.requiresDepthNormalAtEvent = (RenderPassEvent)Mathf.Min((int)pass.renderPassEvent, (int)inputSummary.requiresDepthNormalAtEvent);
            }

            return inputSummary;
        }

        internal override void SwapColorBuffer(CommandBuffer cmd)
        {
            m_ColorBufferSystem.Swap();

            //Check if we are using the depth that is attached to color buffer
            if (ScriptableRendererFeature.m_ActiveCameraDepthAttachment.nameID != BuiltinRenderTextureType.CameraTarget)
                ConfigureCameraTarget(m_ColorBufferSystem.GetBackBuffer(), m_ColorBufferSystem.GetBufferA());
            else
                ConfigureCameraColorTarget(m_ColorBufferSystem.GetBackBuffer());

            ScriptableRendererFeature.m_ActiveCameraColorAttachment = m_ColorBufferSystem.GetBackBuffer();
            cmd.SetGlobalTexture("_CameraColorTexture", ScriptableRendererFeature.m_ActiveCameraColorAttachment.nameID);
        }

        internal override RTHandle GetCameraColorFrontBuffer()
        {
            return m_ColorBufferSystem.GetFrontBuffer();
        }

        internal override RTHandle GetCameraColorBackBuffer()
        {
            return m_ColorBufferSystem.GetBackBuffer();
        }
    }
}
