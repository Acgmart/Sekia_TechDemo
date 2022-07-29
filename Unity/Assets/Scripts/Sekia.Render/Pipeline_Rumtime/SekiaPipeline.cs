using System;
using Unity.Collections;
using System.Collections.Generic;
using Lightmapping = UnityEngine.Experimental.GlobalIllumination.Lightmapping;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace Sekia
{
    public sealed class SekiaPipeline : RenderPipeline
    {
        public static SekiaPipeline Instance;
        public SekiaPipelineAsset asset;

        private readonly DebugDisplaySettingsUI m_DebugDisplaySettingsUI = new DebugDisplaySettingsUI();

        private UniversalRenderPipelineGlobalSettings m_GlobalSettings;
        public override RenderPipelineGlobalSettings defaultSettings => m_GlobalSettings;

        internal SekiaPipeline(SekiaPipelineAsset asset)
        {
            this.asset = asset;
            SekiaPipelineAsset.Instance = asset;
            InitPipelineResource();

            m_GlobalSettings = UniversalRenderPipelineGlobalSettings.instance;
#if UNITY_EDITOR
            Debug.Assert(m_GlobalSettings, "检查设置：Project Settings > Graphics > URP Global Settings");
#endif

            UniversalRenderPipeline.SetSupportedRenderingFeatures();

            //初始化RTHandle system.
            //避免重复分配导致过高的内存使用(释放是延时的).
            RTHandles.Initialize(Screen.width, Screen.height);

            GraphicsSettings.useScriptableRenderPipelineBatching = asset.useSRPBatcher;

            QualitySettings.antiAliasing = 0; //0|2|4|8


            Shader.globalRenderPipeline = "UniversalPipeline";

            Lightmapping.SetDelegate(UniversalRenderPipeline.lightsDelegate);

            CameraCaptureBridge.enabled = true;

            RenderingUtils.ClearSystemInfoCache();

            DecalProjector.defaultMaterial = asset.decalMaterial;

            DebugManager.instance.RefreshEditor();
            m_DebugDisplaySettingsUI.RegisterDebug(UniversalRenderPipelineDebugDisplaySettings.Instance);

            QualitySettings.enableLODCrossFade = asset.enableLODCrossFade;
        }

        public void InitPipelineResource()
        {
            GlobalData.Instance.OnDispose += DisposePipelineResource;

            GlobalData.Instance.graphicsDeviceType = SystemInfo.graphicsDeviceType;
            GlobalData.Instance.IsGLESDevice = SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 ||
                SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES3;
            GlobalData.Instance.IsGLDevice = GlobalData.Instance.IsGLESDevice ||
                SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLCore;

            Blitter.Initialize(asset.m_pipelineResources.coreBlitPS, asset.m_pipelineResources.coreBlitColorAndDepthPS);

            GlobalData.Instance.m_BlitMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.coreBlitPS);
            GlobalData.Instance.m_CopyDepthMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.copyDepthPS);
            GlobalData.Instance.m_SamplingMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.samplingPS);
            GlobalData.Instance.m_StencilDeferredMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.stencilDeferredPS);
            GlobalData.Instance.m_CameraMotionVecMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.cameraMotionVector);
            GlobalData.Instance.m_ObjectMotionVecMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.objectMotionVector);

            StencilStateData stencilData = asset.m_pipelineResources.m_DefaultStencilState;
            GlobalData.Instance.m_DefaultStencilState = StencilState.defaultValue;
            GlobalData.Instance.m_DefaultStencilState.enabled = stencilData.overrideStencilState;
            GlobalData.Instance.m_DefaultStencilState.SetCompareFunction(stencilData.stencilCompareFunction);
            GlobalData.Instance.m_DefaultStencilState.SetPassOperation(stencilData.passOperation);
            GlobalData.Instance.m_DefaultStencilState.SetFailOperation(stencilData.failOperation);
            GlobalData.Instance.m_DefaultStencilState.SetZFailOperation(stencilData.zFailOperation);

            GlobalData.Instance.m_ColorBufferSystem = new SwapBufferSystem("_CameraColorAttachment");

            LensFlareCommonSRP.mergeNeeded = 0;
            LensFlareCommonSRP.maxLensFlareWithOcclusionTemporalSample = 1;
            LensFlareCommonSRP.Initialize();

            {
                GlobalData.Instance.useRenderPassEnabled = asset.m_UseNativeRenderPass && SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;
                GlobalData.Instance.m_RenderingMode = asset.m_RenderingMode;
                GlobalData.Instance.m_Clustering = asset.m_RenderingMode == RenderingMode.ForwardPlus;

                var settings = LightCookieData.Settings.Create();
                settings.atlas.format = asset.additionalLightsCookieFormat;
                settings.atlas.resolution = asset.additionalLightsCookieResolution;
                LightCookieData m_LightCookieManager = new LightCookieData(ref settings);

                ForwardData.InitParams forwardInitParams;
                forwardInitParams.lightCookieManager = m_LightCookieManager;
                forwardInitParams.forwardPlus = asset.m_RenderingMode == RenderingMode.ForwardPlus;
                GlobalData.Instance.m_ForwardLights = new ForwardData(forwardInitParams);

                var deferredInitParams = new DeferredData.InitParams();
                deferredInitParams.stencilDeferredMaterial = GlobalData.Instance.m_StencilDeferredMaterial;
                deferredInitParams.lightCookieManager = m_LightCookieManager;
                GlobalData.Instance.m_DeferredLights = new DeferredData(deferredInitParams, GlobalData.Instance.useRenderPassEnabled);
                GlobalData.Instance.m_DeferredLights.AccurateGbufferNormals = asset.m_AccurateGbufferNormals;
            }
        }

        public void DisposePipelineResource()
        {
            Blitter.Cleanup();

            CoreUtils.Destroy(GlobalData.Instance.m_BlitMaterial);
            CoreUtils.Destroy(GlobalData.Instance.m_CopyDepthMaterial);
            CoreUtils.Destroy(GlobalData.Instance.m_SamplingMaterial);
            CoreUtils.Destroy(GlobalData.Instance.m_StencilDeferredMaterial);
            CoreUtils.Destroy(GlobalData.Instance.m_CameraMotionVecMaterial);
            CoreUtils.Destroy(GlobalData.Instance.m_ObjectMotionVecMaterial);

            GlobalData.Instance.m_ForwardLights.Cleanup();

            GlobalData.Instance.m_ColorBufferSystem.Dispose();
            GlobalData.Instance.m_CameraDepthAttachment?.Release();
            GlobalData.Instance.colorGradingLut?.Release();
            GlobalData.Instance.m_DepthTexture?.Release();
            GlobalData.Instance.m_OpaqueColor?.Release();
            GlobalData.Instance.m_MotionVectorColor?.Release();
            GlobalData.Instance.m_MotionVectorDepth?.Release();
            GlobalData.Instance.m_NormalsTexture?.Release();

            LensFlareCommonSRP.Dispose();
        }

        protected override void Dispose(bool disposing)
        {
            GlobalData.Instance.OnDispose?.Invoke();
            GlobalData.Instance.OnDispose = null;

            m_DebugDisplaySettingsUI.UnregisterDebug();

            base.Dispose(disposing);
            asset = null;
            SekiaPipelineAsset.Instance = null;

            Shader.globalRenderPipeline = "";
            SupportedRenderingFeatures.active = new SupportedRenderingFeatures();
            ShaderData.instance.Dispose();

#if UNITY_EDITOR
            UnityEditor.Rendering.Universal.SceneViewDrawMode.ResetDrawMode();
#endif
            Lightmapping.ResetDelegate();
            CameraCaptureBridge.enabled = false;
        }

        protected override void Render(ScriptableRenderContext renderContext, Camera[] cameras)
        {
            Render(renderContext, new List<Camera>(cameras));
        }

        protected override void Render(ScriptableRenderContext renderContext, List<Camera> cameras)
        {
            //cmd为null：仅用于CPU性能分析 与DrawCall无关
            using var profScope = new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.UniversalRenderTotal));

            using (new ProfilingScope(null, GlobalData.Profiling.beginContextRendering))
            {
                BeginContextRendering(renderContext, cameras);
            }

            GraphicsSettings.lightsUseLinearIntensity = (QualitySettings.activeColorSpace == ColorSpace.Linear);
            GraphicsSettings.lightsUseColorTemperature = true;
            GraphicsSettings.defaultRenderingLayerMask = UniversalRenderPipeline.k_DefaultRenderingLayerMask;
            SetupPerFrameShaderConstants();

#if DEVELOPMENT_BUILD || UNITY_EDITOR
            if (DebugManager.instance.isAnyDebugUIActive)
                UniversalRenderPipelineDebugDisplaySettings.Instance.UpdateFrameTiming();
#endif

            UniversalRenderPipeline.SortCameras(cameras);
            for (int i = 0; i < cameras.Count; ++i)
            {
                var camera = cameras[i];
                if (UniversalRenderPipeline.IsGameCamera(camera))
                {
                    RenderCameraStack(renderContext, camera);
                }
                else
                {
                    using (new ProfilingScope(null, GlobalData.Profiling.beginCameraRendering))
                    {
                        BeginCameraRendering(renderContext, camera);
                    }
#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
                    //It should be called before culling to prepare material. When there isn't any VisualEffect component, this method has no effect.
                    UnityEngine.VFX.VFXManager.PrepareCamera(camera);
#endif
                    UniversalRenderPipeline.UpdateVolumeFramework(camera, null);

                    RenderSingleCameraInternal(renderContext, camera);

                    using (new ProfilingScope(null, GlobalData.Profiling.endCameraRendering))
                    {
                        EndCameraRendering(renderContext, camera);
                    }
                }
            }

            using (new ProfilingScope(null, GlobalData.Profiling.endContextRendering))
            {
                EndContextRendering(renderContext, cameras);
            }
        }

        protected override bool IsRenderRequestSupported<RequestData>(Camera camera, RequestData data)
        {
            if (data is StandardRequest)
                return true;
            else if (data is UniversalRenderPipeline.SingleCameraRequest)
                return true;

            return false;
        }

        protected override void ProcessRenderRequests<RequestData>(ScriptableRenderContext context, Camera camera, RequestData renderRequest)
        {
            StandardRequest standardRequest = renderRequest as StandardRequest;
            UniversalRenderPipeline.SingleCameraRequest singleRequest = renderRequest as UniversalRenderPipeline.SingleCameraRequest;

            if (standardRequest != null || singleRequest != null)
            {
                RenderTexture destination = standardRequest != null ? standardRequest.destination : singleRequest.destination;
                int mipLevel = standardRequest != null ? standardRequest.mipLevel : singleRequest.mipLevel;
                int slice = standardRequest != null ? standardRequest.slice : singleRequest.slice;
                int face = standardRequest != null ? (int)standardRequest.face : (int)singleRequest.face;

                //store data that will be changed
                var orignalTarget = camera.targetTexture;

                //set data
                RenderTexture temporaryRT = null;
                RenderTextureDescriptor RTDesc = destination.descriptor;
                //need to set use default constructor of RenderTextureDescriptor which doesn't enable allowVerticalFlip which matters for cubemaps.
                if (destination.dimension == TextureDimension.Cube)
                    RTDesc = new RenderTextureDescriptor();

                RTDesc.colorFormat = destination.format;
                RTDesc.volumeDepth = 1;
                RTDesc.msaaSamples = destination.descriptor.msaaSamples;
                RTDesc.dimension = TextureDimension.Tex2D;
                RTDesc.width = destination.width / (int)Math.Pow(2, mipLevel);
                RTDesc.height = destination.height / (int)Math.Pow(2, mipLevel);
                RTDesc.width = Mathf.Max(1, RTDesc.width);
                RTDesc.height = Mathf.Max(1, RTDesc.height);

                //if mip is 0 and target is Texture2D we can immediately render to the requested destination
                if (destination.dimension != TextureDimension.Tex2D || mipLevel != 0)
                {
                    temporaryRT = RenderTexture.GetTemporary(RTDesc);
                }

                camera.targetTexture = temporaryRT ? temporaryRT : destination;

                if (standardRequest != null)
                {
                    Render(context, new Camera[] { camera });
                }
                else
                {
                    RenderSingleCameraInternal(context, camera);
                }

                if (temporaryRT)
                {
                    switch (destination.dimension)
                    {
                        case TextureDimension.Tex2D:
                        case TextureDimension.Tex2DArray:
                        case TextureDimension.Tex3D:
                            Graphics.CopyTexture(temporaryRT, 0, 0, destination, slice, mipLevel);
                            break;
                        case TextureDimension.Cube:
                        case TextureDimension.CubeArray:
                            Graphics.CopyTexture(temporaryRT, 0, 0, destination, face + slice * 6, mipLevel);
                            break;
                    }
                }

                //restore data
                camera.targetTexture = orignalTarget;
                Graphics.SetRenderTarget(orignalTarget);
                RenderTexture.ReleaseTemporary(temporaryRT);
            }
            else
            {
                Debug.LogWarning("The given RenderRequest type: " + typeof(RequestData).FullName + ", is either invalid or unsupported by the current pipeline");
            }
        }

        /// <summary>
        /// Standalone camera rendering. Use this to render procedural cameras.
        /// This method doesn't call <c>BeginCameraRendering</c> and <c>EndCameraRendering</c> callbacks.
        /// 不能用来提交渲染请求
        /// </summary>
        /// <param name="context">Render context used to record commands during execution.</param>
        /// <param name="camera">Camera to render.</param>
        /// <seealso cref="ScriptableRenderContext"/>
        internal static void RenderSingleCameraInternal(ScriptableRenderContext context, Camera camera)
        {
            UniversalAdditionalCameraData additionalCameraData = null;
            if (UniversalRenderPipeline.IsGameCamera(camera))
                camera.gameObject.TryGetComponent(out additionalCameraData);

            if (additionalCameraData != null && additionalCameraData.renderType != CameraRenderType.Base)
            {
                Debug.LogWarning("Only Base cameras can be rendered with standalone RenderSingleCamera. Camera will be skipped.");
                return;
            }

            InitializeCameraData(camera, additionalCameraData, true, out var cameraData);
            RenderSingleCamera(context, ref cameraData, cameraData.postProcessEnabled);
        }

        /// <summary>
        /// Renders a single camera. This method will do culling, setup and execution of the renderer.
        /// </summary>
        /// <param name="context">Render context used to record commands during execution.</param>
        /// <param name="cameraData">Camera rendering data. This might contain data inherited from a base camera.</param>
        /// <param name="anyPostProcessingEnabled">True if at least one camera has post-processing enabled in the stack, false otherwise.</param>
        static void RenderSingleCamera(ScriptableRenderContext context, ref CameraData cameraData, bool anyPostProcessingEnabled)
        {
            Camera camera = cameraData.camera;
            var renderer = cameraData.renderer;
            if (renderer == null)
            {
                Debug.LogWarning(string.Format("Trying to render {0} with an invalid renderer. Camera rendering will be skipped.", camera.name));
                return;
            }

            if (!camera.TryGetCullingParameters(false, out var cullingParameters))
                return;

            bool isSceneViewCamera = cameraData.isSceneViewCamera;

            // NOTE: Do NOT mix ProfilingScope with named CommandBuffers i.e. CommandBufferPool.Get("name").
            // Currently there's an issue which results in mismatched markers.
            // The named CommandBuffer will close its "profiling scope" on execution.
            // That will orphan ProfilingScope markers as the named CommandBuffer markers are their parents.
            // Resulting in following pattern:
            // exec(cmd.start, scope.start, cmd.end) and exec(cmd.start, scope.end, cmd.end)
            CommandBuffer cmd = CommandBufferPool.Get();
            ProfilingSampler sampler = GlobalData.Profiling.TryGetOrAddCameraSampler(camera);
            using (new ProfilingScope(cmd, sampler)) // Enqueues a "BeginSample" command into the CommandBuffer cmd
            {
                renderer.Clear(cameraData.renderType);

                using (new ProfilingScope(null, GlobalData.Profiling.setupCullingParameters))
                {
                    renderer.SetupCullingParameters(ref cullingParameters, ref cameraData);
                }

                context.ExecuteCommandBuffer(cmd); // Send all the commands enqueued so far in the CommandBuffer cmd, to the ScriptableRenderContext context
                cmd.Clear();

#if UNITY_EDITOR
                // Emit scene view UI
                if (isSceneViewCamera)
                    ScriptableRenderContext.EmitWorldGeometryForSceneView(camera);
                else
#endif
                if (cameraData.camera.targetTexture != null && cameraData.cameraType != CameraType.Preview)
                    ScriptableRenderContext.EmitGeometryForCamera(camera);

                var cullResults = context.Cull(ref cullingParameters);
                InitializeRenderingData(SekiaPipeline.Instance.asset, ref cameraData, ref cullResults, anyPostProcessingEnabled, cmd, out var renderingData);

                RTHandles.SetReferenceSize(cameraData.cameraTargetDescriptor.width, cameraData.cameraTargetDescriptor.height);

                //原版URP：执行Feature的AddRenderPasses方法
                //renderer.AddRenderPasses(ref renderingData);

                using (new ProfilingScope(null, GlobalData.Profiling.setup))
                    renderer.Setup(context, ref renderingData);

                // Timing scope inside
                renderer.Execute(context, ref renderingData);
                CleanupLightData(ref renderingData.lightData);
            } // When ProfilingSample goes out of scope, an "EndSample" command is enqueued into CommandBuffer cmd

            context.ExecuteCommandBuffer(cmd); // Sends to ScriptableRenderContext all the commands enqueued since cmd.Clear, i.e the "EndSample" command
            CommandBufferPool.Release(cmd);

            using (new ProfilingScope(null, GlobalData.Profiling.submit))
            {
                if (renderer.useRenderPassEnabled && !context.SubmitForRenderPassValidation())
                {
                    renderer.useRenderPassEnabled = false;
                    CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.RenderPassEnabled, false);
                    Debug.LogWarning("Rendering command not supported inside a native RenderPass found. Falling back to non-RenderPass rendering path");
                }
                context.Submit(); // Actually execute the commands that we previously sent to the ScriptableRenderContext context
            }

            ScriptableRenderer.current = null;
        }

        /// <summary>
        /// Renders a camera stack. This method calls RenderSingleCamera for each valid camera in the stack.
        /// The last camera resolves the final target to screen.
        /// </summary>
        /// <param name="context">Render context used to record commands during execution.</param>
        /// <param name="camera">Camera to render.</param>
        static void RenderCameraStack(ScriptableRenderContext context, Camera baseCamera)
        {
            using var profScope = new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.RenderCameraStack));

            baseCamera.TryGetComponent<UniversalAdditionalCameraData>(out var baseCameraAdditionalData);

            // Overlay cameras will be rendered stacked while rendering base cameras
            if (baseCameraAdditionalData != null && baseCameraAdditionalData.renderType == CameraRenderType.Overlay)
                return;

            // Renderer contains a stack if it has additional data and the renderer supports stacking
            // The renderer is checked if it supports Base camera. Since Base is the only relevant type at this moment.
            var renderer = baseCameraAdditionalData?.scriptableRenderer;
            List<Camera> cameraStack = baseCameraAdditionalData?.cameraStack;

            bool anyPostProcessingEnabled = baseCameraAdditionalData != null && baseCameraAdditionalData.renderPostProcessing;

            // We need to know the last active camera in the stack to be able to resolve
            // rendering to screen when rendering it. The last camera in the stack is not
            // necessarily the last active one as it users might disable it.
            int lastActiveOverlayCameraIndex = -1;
            if (cameraStack != null)
            {
                var baseCameraRendererType = SekiaPipeline.Instance.asset.GetRenderer(baseCameraAdditionalData.m_RendererIndex).GetType();
                bool shouldUpdateCameraStack = false;

                UniversalRenderPipeline.cameraStackRequiresDepthForPostprocessing = false;

                for (int i = 0; i < cameraStack.Count; ++i)
                {
                    Camera currCamera = cameraStack[i];
                    if (currCamera == null)
                    {
                        shouldUpdateCameraStack = true;
                        continue;
                    }

                    if (currCamera.isActiveAndEnabled)
                    {
                        currCamera.TryGetComponent<UniversalAdditionalCameraData>(out var data);

                        if (data == null || data.renderType != CameraRenderType.Overlay)
                        {
                            Debug.LogWarning($"Stack can only contain Overlay cameras. The camera: {currCamera.name} " +
                                             $"has a type {data.renderType} that is not supported. Will skip rendering.");
                            continue;
                        }

                        UniversalRenderPipeline.cameraStackRequiresDepthForPostprocessing |= UniversalRenderPipeline.CheckPostProcessForDepth();

                        anyPostProcessingEnabled |= data.renderPostProcessing;
                        lastActiveOverlayCameraIndex = i;
                    }
                }
                if (shouldUpdateCameraStack)
                {
                    baseCameraAdditionalData.UpdateCameraStack();
                }
            }

            // Post-processing not supported in GLES2.
            anyPostProcessingEnabled &= SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;

            bool isStackedRendering = lastActiveOverlayCameraIndex != -1;

            //开始渲染相机栈
            using (new ProfilingScope(null, GlobalData.Profiling.beginCameraRendering))
            {
                BeginCameraRendering(context, baseCamera);
            }
            // Update volumeframework before initializing additional camera data
            SekiaPipeline.UpdateVolumeFramework(baseCamera, baseCameraAdditionalData);
            InitializeCameraData(baseCamera, baseCameraAdditionalData, !isStackedRendering, out var baseCameraData);
            RenderTextureDescriptor originalTargetDesc = baseCameraData.cameraTargetDescriptor;

#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
            //It should be called before culling to prepare material. When there isn't any VisualEffect component, this method has no effect.
            UnityEngine.VFX.VFXManager.PrepareCamera(baseCamera);
#endif

            // update the base camera flag so that the scene depth is stored if needed by overlay cameras later in the frame
            baseCameraData.postProcessingRequiresDepthTexture |= UniversalRenderPipeline.cameraStackRequiresDepthForPostprocessing;

            RenderSingleCamera(context, ref baseCameraData, anyPostProcessingEnabled);
            using (new ProfilingScope(null, GlobalData.Profiling.endCameraRendering))
            {
                EndCameraRendering(context, baseCamera);
            }

            if (isStackedRendering)
            {
                for (int i = 0; i < cameraStack.Count; ++i)
                {
                    var currCamera = cameraStack[i];
                    if (!currCamera.isActiveAndEnabled)
                        continue;

                    currCamera.TryGetComponent<UniversalAdditionalCameraData>(out var currCameraData);
                    // Camera is overlay and enabled
                    if (currCameraData != null)
                    {
                        // Copy base settings from base camera data and initialize initialize remaining specific settings for this camera type.
                        CameraData overlayCameraData = baseCameraData;
                        bool lastCamera = i == lastActiveOverlayCameraIndex;

                        using (new ProfilingScope(null, GlobalData.Profiling.beginCameraRendering))
                        {
                            BeginCameraRendering(context, currCamera);
                        }
#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
                        //It should be called before culling to prepare material. When there isn't any VisualEffect component, this method has no effect.
                        UnityEngine.VFX.VFXManager.PrepareCamera(currCamera);
#endif
                        UniversalRenderPipeline.UpdateVolumeFramework(currCamera, currCameraData);
                        InitializeAdditionalCameraData(currCamera, currCameraData, lastCamera, ref overlayCameraData);
                        overlayCameraData.baseCamera = baseCamera;

                        RenderSingleCamera(context, ref overlayCameraData, anyPostProcessingEnabled);

                        using (new ProfilingScope(null, GlobalData.Profiling.endCameraRendering))
                        {
                            EndCameraRendering(context, currCamera);
                        }
                    }
                }
            }
        }

        static void InitializeCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool resolveFinalTarget, out CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.initializeCameraData);

            cameraData = new CameraData();
            InitializeStackedCameraData(camera, additionalCameraData, ref cameraData);
            InitializeAdditionalCameraData(camera, additionalCameraData, resolveFinalTarget, ref cameraData);

            ///////////////////////////////////////////////////////////////////
            // Descriptor settings                                            /
            ///////////////////////////////////////////////////////////////////

            int msaaSamples = 1;
            bool needsAlphaChannel = Graphics.preserveFramebufferAlpha;

            // Render scale is not intended to affect the scene view so override the scale to 1.0 when it's rendered.
            bool isSceneViewCamera = (camera.cameraType == CameraType.SceneView);
            float renderScale = isSceneViewCamera ? 1.0f : cameraData.renderScale;

            cameraData.hdrColorBufferPrecision = SekiaPipeline.Instance.asset ?
                SekiaPipeline.Instance.asset.hdrColorBufferPrecision : HDRColorBufferPrecision._32Bits;
            cameraData.cameraTargetDescriptor = UniversalRenderPipeline.CreateRenderTextureDescriptor(camera, renderScale,
                cameraData.isHdrEnabled, cameraData.hdrColorBufferPrecision, msaaSamples, needsAlphaChannel, cameraData.requiresOpaqueTexture);
        }

        /// <summary>
        /// Initialize camera data settings common for all cameras in the stack. Overlay cameras will inherit
        /// settings from base camera.
        /// </summary>
        /// <param name="baseCamera">Base camera to inherit settings from.</param>
        /// <param name="baseAdditionalCameraData">Component that contains additional base camera data.</param>
        /// <param name="cameraData">Camera data to initialize setttings.</param>
        static void InitializeStackedCameraData(Camera baseCamera, UniversalAdditionalCameraData baseAdditionalCameraData, ref CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.initializeStackedCameraData);

            var settings = SekiaPipeline.Instance.asset;
            cameraData.targetTexture = baseCamera.targetTexture;
            cameraData.cameraType = baseCamera.cameraType;
            cameraData.xrRendering = false;
            bool isSceneViewCamera = cameraData.isSceneViewCamera;

            ///////////////////////////////////////////////////////////////////
            // Environment and Post-processing settings                       /
            ///////////////////////////////////////////////////////////////////
            if (isSceneViewCamera)
            {
                cameraData.volumeLayerMask = 1; // "Default"
                cameraData.volumeTrigger = null;
                cameraData.isStopNaNEnabled = false;
                cameraData.isDitheringEnabled = false;
                cameraData.antialiasing = AntialiasingMode.None;
                cameraData.antialiasingQuality = AntialiasingQuality.High;
            }
            else if (baseAdditionalCameraData != null)
            {
                cameraData.volumeLayerMask = baseAdditionalCameraData.volumeLayerMask;
                cameraData.volumeTrigger = baseAdditionalCameraData.volumeTrigger == null ? baseCamera.transform : baseAdditionalCameraData.volumeTrigger;
                cameraData.isStopNaNEnabled = baseAdditionalCameraData.stopNaN && SystemInfo.graphicsShaderLevel >= 35;
                cameraData.isDitheringEnabled = baseAdditionalCameraData.dithering;
                cameraData.antialiasing = baseAdditionalCameraData.antialiasing;
                cameraData.antialiasingQuality = baseAdditionalCameraData.antialiasingQuality;
            }
            else
            {
                cameraData.volumeLayerMask = 1; // "Default"
                cameraData.volumeTrigger = null;
                cameraData.isStopNaNEnabled = false;
                cameraData.isDitheringEnabled = false;
                cameraData.antialiasing = AntialiasingMode.None;
                cameraData.antialiasingQuality = AntialiasingQuality.High;
            }

            ///////////////////////////////////////////////////////////////////
            // Settings that control output of the camera                     /
            ///////////////////////////////////////////////////////////////////

            cameraData.isHdrEnabled = baseCamera.allowHDR && settings.supportsHDR;

            Rect cameraRect = baseCamera.rect;
            cameraData.pixelRect = baseCamera.pixelRect;
            cameraData.pixelWidth = baseCamera.pixelWidth;
            cameraData.pixelHeight = baseCamera.pixelHeight;
            cameraData.aspectRatio = (float)cameraData.pixelWidth / (float)cameraData.pixelHeight;
            cameraData.isDefaultViewport = (!(Math.Abs(cameraRect.x) > 0.0f || Math.Abs(cameraRect.y) > 0.0f ||
                Math.Abs(cameraRect.width) < 1.0f || Math.Abs(cameraRect.height) < 1.0f));

            // Discard variations lesser than kRenderScaleThreshold.
            // Scale is only enabled for gameview.
            const float kRenderScaleThreshold = 0.05f;
            cameraData.renderScale = (Mathf.Abs(1.0f - settings.renderScale) < kRenderScaleThreshold) ? 1.0f : settings.renderScale;

            // Convert the upscaling filter selection from the pipeline asset into an image upscaling filter
            cameraData.upscalingFilter = ResolveUpscalingFilterSelection(new Vector2(cameraData.pixelWidth, cameraData.pixelHeight), cameraData.renderScale, settings.upscalingFilter);

            if (cameraData.renderScale > 1.0f)
            {
                cameraData.imageScalingMode = ImageScalingMode.Downscaling;
            }
            else if ((cameraData.renderScale < 1.0f) || (cameraData.upscalingFilter == ImageUpscalingFilter.FSR))
            {
                // When FSR is enabled, we still consider 100% render scale an upscaling operation.
                // This allows us to run the FSR shader passes all the time since they improve visual quality even at 100% scale.

                cameraData.imageScalingMode = ImageScalingMode.Upscaling;
            }
            else
            {
                cameraData.imageScalingMode = ImageScalingMode.None;
            }

            cameraData.fsrOverrideSharpness = settings.fsrOverrideSharpness;
            cameraData.fsrSharpness = settings.fsrSharpness;

            var commonOpaqueFlags = SortingCriteria.CommonOpaque;
            var noFrontToBackOpaqueFlags = SortingCriteria.SortingLayer | SortingCriteria.RenderQueue | SortingCriteria.OptimizeStateChanges | SortingCriteria.CanvasOrder;
            bool hasHSRGPU = SystemInfo.hasHiddenSurfaceRemovalOnGPU;
            bool canSkipFrontToBackSorting = (baseCamera.opaqueSortMode == OpaqueSortMode.Default && hasHSRGPU) || baseCamera.opaqueSortMode == OpaqueSortMode.NoDistanceSort;

            cameraData.defaultOpaqueSortFlags = canSkipFrontToBackSorting ? noFrontToBackOpaqueFlags : commonOpaqueFlags;
            cameraData.captureActions = CameraCaptureBridge.GetCaptureActions(baseCamera);
        }

        /// <summary>
        /// Initialize settings that can be different for each camera in the stack.
        /// </summary>
        /// <param name="camera">Camera to initialize settings from.</param>
        /// <param name="additionalCameraData">Additional camera data component to initialize settings from.</param>
        /// <param name="resolveFinalTarget">True if this is the last camera in the stack and rendering should resolve to camera target.</param>
        /// <param name="cameraData">Settings to be initilized.</param>
        static void InitializeAdditionalCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool resolveFinalTarget, ref CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.initializeAdditionalCameraData);

            var settings = SekiaPipeline.Instance.asset;
            cameraData.camera = camera;

            bool anyShadowsEnabled = settings.supportsMainLightShadows || settings.supportsAdditionalLightShadows;
            cameraData.maxShadowDistance = Mathf.Min(settings.shadowDistance, camera.farClipPlane);
            cameraData.maxShadowDistance = (anyShadowsEnabled && cameraData.maxShadowDistance >= camera.nearClipPlane) ? cameraData.maxShadowDistance : 0.0f;

            bool isSceneViewCamera = cameraData.isSceneViewCamera;
            if (isSceneViewCamera)
            {
                cameraData.renderType = CameraRenderType.Base;
                cameraData.clearDepth = true;
                cameraData.postProcessEnabled = CoreUtils.ArePostProcessesEnabled(camera);
                cameraData.renderer = SekiaPipeline.Instance.asset.defaultRenderer;
                cameraData.useScreenCoordOverride = false;
                cameraData.screenSizeOverride = cameraData.pixelRect.size;
                cameraData.screenCoordScaleBias = Vector2.one;
            }
            else if (additionalCameraData != null)
            {
                cameraData.renderType = additionalCameraData.renderType;
                cameraData.clearDepth = (additionalCameraData.renderType != CameraRenderType.Base) ? additionalCameraData.clearDepth : true;
                cameraData.postProcessEnabled = additionalCameraData.renderPostProcessing;
                cameraData.maxShadowDistance = (additionalCameraData.renderShadows) ? cameraData.maxShadowDistance : 0.0f;
                cameraData.renderer = SekiaPipeline.Instance.asset.GetRenderer(additionalCameraData.m_RendererIndex);
                cameraData.useScreenCoordOverride = additionalCameraData.useScreenCoordOverride;
                cameraData.screenSizeOverride = additionalCameraData.screenSizeOverride;
                cameraData.screenCoordScaleBias = additionalCameraData.screenCoordScaleBias;
            }
            else
            {
                cameraData.renderType = CameraRenderType.Base;
                cameraData.clearDepth = true;
                cameraData.postProcessEnabled = false;
                cameraData.renderer = SekiaPipeline.Instance.asset.defaultRenderer;
                cameraData.useScreenCoordOverride = false;
                cameraData.screenSizeOverride = cameraData.pixelRect.size;
                cameraData.screenCoordScaleBias = Vector2.one;
            }

            // Disables post if GLes2
            cameraData.postProcessEnabled &= SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;

            cameraData.requiresDepthTexture |= isSceneViewCamera;
            cameraData.postProcessingRequiresDepthTexture = GlobalLogic.CheckPostProcessForDepth(ref cameraData);
            cameraData.resolveFinalTarget = resolveFinalTarget;

            // Disable depth and color copy. We should add it in the renderer instead to avoid performance pitfalls
            // of camera stacking breaking render pass execution implicitly.
            bool isOverlayCamera = (cameraData.renderType == CameraRenderType.Overlay);
            if (isOverlayCamera)
            {
                cameraData.requiresOpaqueTexture = false;
            }

            Matrix4x4 projectionMatrix = camera.projectionMatrix;

            // Overlay cameras inherit viewport from base.
            // If the viewport is different between them we might need to patch the projection to adjust aspect ratio
            // matrix to prevent squishing when rendering objects in overlay cameras.
            if (isOverlayCamera && !camera.orthographic && cameraData.pixelRect != camera.pixelRect)
            {
                // m00 = (cotangent / aspect), therefore m00 * aspect gives us cotangent.
                float cotangent = camera.projectionMatrix.m00 * camera.aspect;

                // Get new m00 by dividing by base camera aspectRatio.
                float newCotangent = cotangent / cameraData.aspectRatio;
                projectionMatrix.m00 = newCotangent;
            }

            cameraData.SetViewAndProjectionMatrix(camera.worldToCameraMatrix, projectionMatrix);

            cameraData.worldSpaceCameraPos = camera.transform.position;

            var backgroundColorSRGB = camera.backgroundColor;
            // Get the background color from preferences if preview camera
#if UNITY_EDITOR
            if (camera.cameraType == CameraType.Preview && camera.clearFlags != CameraClearFlags.SolidColor)
            {
                backgroundColorSRGB = CoreRenderPipelinePreferences.previewBackgroundColor;
            }
#endif

            cameraData.backgroundColor = CoreUtils.ConvertSRGBToActiveColorSpace(backgroundColorSRGB);
        }

        static void InitializeRenderingData(SekiaPipelineAsset settings, ref CameraData cameraData, ref CullingResults cullResults,
            bool anyPostProcessingEnabled, CommandBuffer cmd, out RenderingData renderingData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.initializeRenderingData);

            var visibleLights = cullResults.visibleLights;

            int mainLightIndex = GetMainLightIndex(settings, visibleLights);
            bool mainLightCastShadows = false;
            bool additionalLightsCastShadows = false;

            if (cameraData.maxShadowDistance > 0.0f)
            {
                mainLightCastShadows = (mainLightIndex != -1 && visibleLights[mainLightIndex].light != null &&
                    visibleLights[mainLightIndex].light.shadows != LightShadows.None);

                // If additional lights are shaded per-vertex they cannot cast shadows
                if (settings.additionalLightsRenderingMode == LightRenderingMode.PerPixel)
                {
                    for (int i = 0; i < visibleLights.Length; ++i)
                    {
                        if (i == mainLightIndex)
                            continue;

                        ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(i);
                        Light light = vl.light;

                        // UniversalRP doesn't support additional directional light shadows yet
                        if ((vl.lightType == LightType.Spot || vl.lightType == LightType.Point) && light != null && light.shadows != LightShadows.None)
                        {
                            additionalLightsCastShadows = true;
                            break;
                        }
                    }
                }
            }

            renderingData.cullResults = cullResults;
            renderingData.cameraData = cameraData;
            InitializeLightData(settings, visibleLights, mainLightIndex, out renderingData.lightData);
            InitializeShadowData(settings, visibleLights, mainLightCastShadows, additionalLightsCastShadows && !renderingData.lightData.shadeAdditionalLightsPerVertex, out renderingData.shadowData);
            InitializePostProcessingData(settings, out renderingData.postProcessingData);
            renderingData.supportsDynamicBatching = settings.supportsDynamicBatching;
            renderingData.perObjectData = GetPerObjectLightFlags(renderingData.lightData.additionalLightsCount, GlobalData.Instance.m_Clustering);
            renderingData.postProcessingEnabled = anyPostProcessingEnabled;
            renderingData.commandBuffer = cmd;

            CheckAndApplyDebugSettings(ref renderingData);
        }

        static void InitializeShadowData(SekiaPipelineAsset settings, NativeArray<VisibleLight> visibleLights, bool mainLightCastShadows, bool additionalLightsCastShadows, out ShadowData shadowData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.initializeShadowData);

            UniversalRenderPipeline.m_ShadowBiasData.Clear();
            UniversalRenderPipeline.m_ShadowResolutionData.Clear();

            for (int i = 0; i < visibleLights.Length; ++i)
            {
                ref VisibleLight vl = ref visibleLights.UnsafeElementAtMutable(i);
                Light light = vl.light;
                UniversalAdditionalLightData data = null;
                if (light != null)
                {
                    light.gameObject.TryGetComponent(out data);
                }

                if (data && !data.usePipelineSettings)
                    UniversalRenderPipeline.m_ShadowBiasData.Add(new Vector4(light.shadowBias, light.shadowNormalBias, 0.0f, 0.0f));
                else
                    UniversalRenderPipeline.m_ShadowBiasData.Add(new Vector4(settings.shadowDepthBias, settings.shadowNormalBias, 0.0f, 0.0f));

                if (data && (data.additionalLightsShadowResolutionTier == UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierCustom))
                {
                    UniversalRenderPipeline.m_ShadowResolutionData.Add((int)light.shadowResolution); // native code does not clamp light.shadowResolution between -1 and 3
                }
                else if (data && (data.additionalLightsShadowResolutionTier != UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierCustom))
                {
                    int resolutionTier = Mathf.Clamp(data.additionalLightsShadowResolutionTier, UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierLow, UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierHigh);
                    UniversalRenderPipeline.m_ShadowResolutionData.Add(settings.GetAdditionalLightsShadowResolution(resolutionTier));
                }
                else
                {
                    UniversalRenderPipeline.m_ShadowResolutionData.Add(settings.GetAdditionalLightsShadowResolution(UniversalAdditionalLightData.AdditionalLightsShadowDefaultResolutionTier));
                }
            }

            shadowData.bias = UniversalRenderPipeline.m_ShadowBiasData;
            shadowData.resolution = UniversalRenderPipeline.m_ShadowResolutionData;
            shadowData.supportsMainLightShadows = SystemInfo.supportsShadows && settings.supportsMainLightShadows && mainLightCastShadows;

            // We no longer use screen space shadows in URP.
            // This change allows us to have particles & transparent objects receive shadows.
#pragma warning disable 0618
            shadowData.requiresScreenSpaceShadowResolve = false;
#pragma warning restore 0618

            // On GLES2 we strip the cascade keywords from the lighting shaders, so for consistency we force disable the cascades here too
            shadowData.mainLightShadowCascadesCount = SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 ? 1 : settings.shadowCascadeCount;
            shadowData.mainLightShadowmapWidth = settings.mainLightShadowmapResolution;
            shadowData.mainLightShadowmapHeight = settings.mainLightShadowmapResolution;

            switch (shadowData.mainLightShadowCascadesCount)
            {
                case 1:
                    shadowData.mainLightShadowCascadesSplit = new Vector3(1.0f, 0.0f, 0.0f);
                    break;

                case 2:
                    shadowData.mainLightShadowCascadesSplit = new Vector3(settings.cascade2Split, 1.0f, 0.0f);
                    break;

                case 3:
                    shadowData.mainLightShadowCascadesSplit = new Vector3(settings.cascade3Split.x, settings.cascade3Split.y, 0.0f);
                    break;

                default:
                    shadowData.mainLightShadowCascadesSplit = settings.cascade4Split;
                    break;
            }

            shadowData.mainLightShadowCascadeBorder = settings.cascadeBorder;

            shadowData.supportsAdditionalLightShadows = SystemInfo.supportsShadows && settings.supportsAdditionalLightShadows && additionalLightsCastShadows;
            shadowData.additionalLightsShadowmapWidth = shadowData.additionalLightsShadowmapHeight = settings.additionalLightsShadowmapResolution;
            shadowData.supportsSoftShadows = settings.supportsSoftShadows && (shadowData.supportsMainLightShadows || shadowData.supportsAdditionalLightShadows);
            shadowData.shadowmapDepthBufferBits = 16;

            // This will be setup in AdditionalLightsShadowCasterPass.
            shadowData.isKeywordAdditionalLightShadowsEnabled = false;
            shadowData.isKeywordSoftShadowsEnabled = false;
        }

        static void InitializePostProcessingData(SekiaPipelineAsset settings, out PostProcessingData postProcessingData)
        {
            postProcessingData.gradingMode = settings.supportsHDR
                ? settings.colorGradingMode
                : ColorGradingMode.LowDynamicRange;

            postProcessingData.lutSize = settings.colorGradingLutSize;
            postProcessingData.useFastSRGBLinearConversion = settings.useFastSRGBLinearConversion;
        }

        static void InitializeLightData(SekiaPipelineAsset settings, NativeArray<VisibleLight> visibleLights, int mainLightIndex, out LightData lightData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.initializeLightData);

            int maxPerObjectAdditionalLights = UniversalRenderPipeline.maxPerObjectLights;
            int maxVisibleAdditionalLights = UniversalRenderPipeline.maxVisibleAdditionalLights;

            lightData.mainLightIndex = mainLightIndex;

            if (settings.additionalLightsRenderingMode != LightRenderingMode.Disabled)
            {
                lightData.additionalLightsCount =
                    Math.Min((mainLightIndex != -1) ? visibleLights.Length - 1 : visibleLights.Length,
                        maxVisibleAdditionalLights);
                lightData.maxPerObjectAdditionalLightsCount = Math.Min(settings.maxAdditionalLightsCount, maxPerObjectAdditionalLights);
            }
            else
            {
                lightData.additionalLightsCount = 0;
                lightData.maxPerObjectAdditionalLightsCount = 0;
            }

            lightData.supportsAdditionalLights = settings.additionalLightsRenderingMode != LightRenderingMode.Disabled;
            lightData.shadeAdditionalLightsPerVertex = settings.additionalLightsRenderingMode == LightRenderingMode.PerVertex;
            lightData.visibleLights = visibleLights;
            lightData.supportsMixedLighting = settings.supportsMixedLighting;
            lightData.reflectionProbeBlending = settings.reflectionProbeBlending;
            lightData.reflectionProbeBoxProjection = settings.reflectionProbeBoxProjection;
            lightData.supportsLightLayers = RenderingUtils.SupportsLightLayers(SystemInfo.graphicsDeviceType) && settings.useRenderingLayers;
            lightData.originalIndices = new NativeArray<int>(visibleLights.Length, Allocator.Temp);
            for (var i = 0; i < lightData.originalIndices.Length; i++)
            {
                lightData.originalIndices[i] = i;
            }
        }

        static void CleanupLightData(ref LightData lightData)
        {
            lightData.originalIndices.Dispose();
        }

        static PerObjectData GetPerObjectLightFlags(int additionalLightsCount, bool clustering)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.getPerObjectLightFlags);

            var configuration = PerObjectData.ReflectionProbes | PerObjectData.Lightmaps | PerObjectData.LightProbe | PerObjectData.LightData | PerObjectData.OcclusionProbe | PerObjectData.ShadowMask;

            if (additionalLightsCount > 0 && !clustering)
            {
                configuration |= PerObjectData.LightData;

                // In this case we also need per-object indices (unity_LightIndices)
                if (!RenderingUtils.useStructuredBuffer)
                    configuration |= PerObjectData.LightIndices;
            }

            return configuration;
        }

        // Main Light is always a directional light
        static int GetMainLightIndex(SekiaPipelineAsset settings, NativeArray<VisibleLight> visibleLights)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.getMainLightIndex);

            int totalVisibleLights = visibleLights.Length;

            if (totalVisibleLights == 0 || settings.mainLightRenderingMode != LightRenderingMode.PerPixel)
                return -1;

            Light sunLight = RenderSettings.sun;
            int brightestDirectionalLightIndex = -1;
            float brightestLightIntensity = 0.0f;
            for (int i = 0; i < totalVisibleLights; ++i)
            {
                ref VisibleLight currVisibleLight = ref visibleLights.UnsafeElementAtMutable(i);
                Light currLight = currVisibleLight.light;

                // Particle system lights have the light property as null. We sort lights so all particles lights
                // come last. Therefore, if first light is particle light then all lights are particle lights.
                // In this case we either have no main light or already found it.
                if (currLight == null)
                    break;

                if (currVisibleLight.lightType == LightType.Directional)
                {
                    // Sun source needs be a directional light
                    if (currLight == sunLight)
                        return i;

                    // In case no sun light is present we will return the brightest directional light
                    if (currLight.intensity > brightestLightIntensity)
                    {
                        brightestLightIntensity = currLight.intensity;
                        brightestDirectionalLightIndex = i;
                    }
                }
            }

            return brightestDirectionalLightIndex;
        }

        static void SetupPerFrameShaderConstants()
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.setupPerFrameShaderConstants);

            // When glossy reflections are OFF in the shader we set a constant color to use as indirect specular
            SphericalHarmonicsL2 ambientSH = RenderSettings.ambientProbe;
            Color linearGlossyEnvColor = new Color(ambientSH[0, 0], ambientSH[1, 0], ambientSH[2, 0]) * RenderSettings.reflectionIntensity;
            Color glossyEnvColor = CoreUtils.ConvertLinearToActiveColorSpace(linearGlossyEnvColor);
            Shader.SetGlobalVector(ShaderPropertyId.glossyEnvironmentColor, glossyEnvColor);

            // Used as fallback cubemap for reflections
            Shader.SetGlobalVector(ShaderPropertyId.glossyEnvironmentCubeMapHDR, ReflectionProbe.defaultTextureHDRDecodeValues);
            Shader.SetGlobalTexture(ShaderPropertyId.glossyEnvironmentCubeMap, ReflectionProbe.defaultTexture);

            // Ambient
            Shader.SetGlobalVector(ShaderPropertyId.ambientSkyColor, CoreUtils.ConvertSRGBToActiveColorSpace(RenderSettings.ambientSkyColor));
            Shader.SetGlobalVector(ShaderPropertyId.ambientEquatorColor, CoreUtils.ConvertSRGBToActiveColorSpace(RenderSettings.ambientEquatorColor));
            Shader.SetGlobalVector(ShaderPropertyId.ambientGroundColor, CoreUtils.ConvertSRGBToActiveColorSpace(RenderSettings.ambientGroundColor));

            // Used when subtractive mode is selected
            Shader.SetGlobalVector(ShaderPropertyId.subtractiveShadowColor, CoreUtils.ConvertSRGBToActiveColorSpace(RenderSettings.subtractiveShadowColor));

            // Required for 2D Unlit Shadergraph master node as it doesn't currently support hidden properties.
            Shader.SetGlobalColor(ShaderPropertyId.rendererColor, Color.white);

            //LodCrossFadeDithering
            if (SekiaPipeline.Instance.asset.lodCrossFadeDitheringType == LODCrossFadeDitheringType.BayerMatrix)
            {
                Shader.SetGlobalFloat(ShaderPropertyId.ditheringTextureInvSize, 1.0f / SekiaPipeline.Instance.asset.textures.bayerMatrixTex.width);
                Shader.SetGlobalTexture(ShaderPropertyId.ditheringTexture, SekiaPipeline.Instance.asset.textures.bayerMatrixTex);
            }
            else if (SekiaPipeline.Instance.asset.lodCrossFadeDitheringType == LODCrossFadeDitheringType.BlueNoise)
            {
                Shader.SetGlobalFloat(ShaderPropertyId.ditheringTextureInvSize, 1.0f / SekiaPipeline.Instance.asset.textures.blueNoise64LTex.width);
                Shader.SetGlobalTexture(ShaderPropertyId.ditheringTexture, SekiaPipeline.Instance.asset.textures.blueNoise64LTex);
            }

            //时间变量
            {
                //docs.unity3d.com/Manual/SL-UnityShaderVariables.html
                float time = Time.time;
#if UNITY_EDITOR
                time = Application.isPlaying ? Time.time : Time.realtimeSinceStartup;
#endif
                float deltaTime = Time.deltaTime;
                float smoothDeltaTime = Time.smoothDeltaTime;

                float timeEights = time / 8f;
                float timeFourth = time / 4f;
                float timeHalf = time / 2f;

                // Time values
                Vector4 timeVector = time * new Vector4(1f / 20f, 1f, 2f, 3f);
                Vector4 sinTimeVector = new Vector4(Mathf.Sin(timeEights), Mathf.Sin(timeFourth), Mathf.Sin(timeHalf), Mathf.Sin(time));
                Vector4 cosTimeVector = new Vector4(Mathf.Cos(timeEights), Mathf.Cos(timeFourth), Mathf.Cos(timeHalf), Mathf.Cos(time));
                Vector4 deltaTimeVector = new Vector4(deltaTime, 1f / deltaTime, smoothDeltaTime, 1f / smoothDeltaTime);
                Vector4 timeParametersVector = new Vector4(time, Mathf.Sin(time), Mathf.Cos(time), 0.0f);

                Shader.SetGlobalVector(ShaderPropertyId.time, timeVector);
                Shader.SetGlobalVector(ShaderPropertyId.sinTime, sinTimeVector);
                Shader.SetGlobalVector(ShaderPropertyId.cosTime, cosTimeVector);
                Shader.SetGlobalVector(ShaderPropertyId.deltaTime, deltaTimeVector);
                Shader.SetGlobalVector(ShaderPropertyId.timeParameters, timeParametersVector);
            }
        }

        static void CheckAndApplyDebugSettings(ref RenderingData renderingData)
        {
            var debugDisplaySettings = UniversalRenderPipelineDebugDisplaySettings.Instance;
            ref CameraData cameraData = ref renderingData.cameraData;

            if (debugDisplaySettings.AreAnySettingsActive && !cameraData.isPreviewCamera)
            {
                DebugDisplaySettingsRendering renderingSettings = debugDisplaySettings.renderingSettings;
                int msaaSamples = cameraData.cameraTargetDescriptor.msaaSamples;

                if (!renderingSettings.enableMsaa)
                    msaaSamples = 1;

                if (!renderingSettings.enableHDR)
                    cameraData.isHdrEnabled = false;

                if (!debugDisplaySettings.IsPostProcessingAllowed)
                    cameraData.postProcessEnabled = false;

                cameraData.hdrColorBufferPrecision = SekiaPipeline.Instance.asset ? SekiaPipeline.Instance.asset.hdrColorBufferPrecision : HDRColorBufferPrecision._32Bits;
                cameraData.cameraTargetDescriptor.graphicsFormat = UniversalRenderPipeline.MakeRenderTextureGraphicsFormat(cameraData.isHdrEnabled, cameraData.hdrColorBufferPrecision, true);
                cameraData.cameraTargetDescriptor.msaaSamples = msaaSamples;

            }
        }

        /// <summary>
        /// Returns the best supported image upscaling filter based on the provided upscaling filter selection
        /// </summary>
        /// <param name="imageSize">Size of the final image</param>
        /// <param name="renderScale">Scale being applied to the final image size</param>
        /// <param name="selection">Upscaling filter selected by the user</param>
        /// <returns>Either the original filter provided, or the best replacement available</returns>
        static ImageUpscalingFilter ResolveUpscalingFilterSelection(Vector2 imageSize, float renderScale, UpscalingFilterSelection selection)
        {
            // By default we just use linear filtering since it's the most compatible choice
            ImageUpscalingFilter filter = ImageUpscalingFilter.Linear;

            // Fall back to the automatic filter if FSR was selected, but isn't supported on the current platform
            if ((selection == UpscalingFilterSelection.FSR) && !FSRUtils.IsSupported())
            {
                selection = UpscalingFilterSelection.Auto;
            }

            switch (selection)
            {
                case UpscalingFilterSelection.Auto:
                    {
                        // The user selected "auto" for their upscaling filter so we should attempt to choose the best filter
                        // for the current situation. When the current resolution and render scale are compatible with integer
                        // scaling we use the point sampling filter. Otherwise we just use the default filter (linear).
                        float pixelScale = (1.0f / renderScale);
                        bool isIntegerScale = Mathf.Approximately((pixelScale - Mathf.Floor(pixelScale)), 0.0f);

                        if (isIntegerScale)
                        {
                            float widthScale = (imageSize.x / pixelScale);
                            float heightScale = (imageSize.y / pixelScale);

                            bool isImageCompatible = (Mathf.Approximately((widthScale - Mathf.Floor(widthScale)), 0.0f) &&
                                                      Mathf.Approximately((heightScale - Mathf.Floor(heightScale)), 0.0f));

                            if (isImageCompatible)
                            {
                                filter = ImageUpscalingFilter.Point;
                            }
                        }

                        break;
                    }

                case UpscalingFilterSelection.Linear:
                    {
                        // Do nothing since linear is already the default

                        break;
                    }

                case UpscalingFilterSelection.Point:
                    {
                        filter = ImageUpscalingFilter.Point;

                        break;
                    }

                case UpscalingFilterSelection.FSR:
                    {
                        filter = ImageUpscalingFilter.FSR;

                        break;
                    }
            }

            return filter;
        }

        #region UniversalAdditionalCameraData逻辑
        internal static bool RequiresVolumeFrameworkUpdate(UniversalAdditionalCameraData additionalCameraData)
        {
            VolumeFrameworkUpdateMode cameraVolumeFrameworkUpdateModeOption = additionalCameraData.m_VolumeFrameworkUpdateModeOption;
            if (cameraVolumeFrameworkUpdateModeOption == VolumeFrameworkUpdateMode.UsePipelineSettings)
                return SekiaPipeline.Instance.asset.volumeFrameworkUpdateMode != VolumeFrameworkUpdateMode.ViaScripting;
            return cameraVolumeFrameworkUpdateModeOption == VolumeFrameworkUpdateMode.EveryFrame;
        }

        #endregion

        internal static void UpdateVolumeFramework(Camera camera, UniversalAdditionalCameraData additionalCameraData)
        {
            using var profScope = new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.UpdateVolumeFramework));

            // We update the volume framework for:
            // * All cameras in the editor when not in playmode
            // * scene cameras
            // * cameras with update mode set to EveryFrame
            // * cameras with update mode set to UsePipelineSettings and the URP Asset set to EveryFrame
            bool shouldUpdate = camera.cameraType == CameraType.SceneView;
            shouldUpdate |= additionalCameraData != null && RequiresVolumeFrameworkUpdate(additionalCameraData);

#if UNITY_EDITOR
            shouldUpdate |= Application.isPlaying == false;
#endif

            // When we have volume updates per-frame disabled...
            if (!shouldUpdate && additionalCameraData)
            {
                // Create a local volume stack and cache the state if it's null
                if (additionalCameraData.volumeStack == null)
                {
                    camera.UpdateVolumeStack(additionalCameraData);
                }

                VolumeManager.instance.stack = additionalCameraData.volumeStack;
                return;
            }

            // When we want to update the volumes every frame...

            // We destroy the volumeStack in the additional camera data, if present, to make sure
            // it gets recreated and initialized if the update mode gets later changed to ViaScripting...
            if (additionalCameraData && additionalCameraData.volumeStack != null)
            {
                camera.DestroyVolumeStack(additionalCameraData);
            }

            // Get the mask + trigger and update the stack
            camera.GetVolumeLayerMaskAndTrigger(additionalCameraData, out LayerMask layerMask, out Transform trigger);
            VolumeManager.instance.ResetMainStack();
            VolumeManager.instance.Update(trigger, layerMask);
        }
    }
}
