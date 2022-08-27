using System;
using Unity.Collections;
using System.Collections.Generic;
using Lightmapping = UnityEngine.Experimental.GlobalIllumination.Lightmapping;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;

namespace Sekia
{
    public sealed class SekiaPipeline : RenderPipeline
    {
        public static SekiaPipeline Instance;
        public SekiaPipelineAsset asset;

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

            GlobalLogic.SetSupportedRenderingFeatures();
            GraphicsSettings.useScriptableRenderPipelineBatching = asset.useSRPBatcher;
            QualitySettings.antiAliasing = 0; //0|2|4|8
            Shader.globalRenderPipeline = "UniversalPipeline";
            Lightmapping.SetDelegate(GlobalLogic.lightsDelegate);
            DebugManager.instance.RefreshEditor();
        }

        public void InitPipelineResource()
        {
            if (GlobalData.Instance == null)
                GlobalData.Instance = new GlobalData();
            var ins = GlobalData.Instance;
            ins.OnDispose += DisposePipelineResource;

            //收集硬件支持信息
            ins.graphicsDeviceType = SystemInfo.graphicsDeviceType;
            ins.graphicsShaderLevel = SystemInfo.graphicsShaderLevel;
            ins.supportedRenderTargetCount = SystemInfo.supportedRenderTargetCount;
            ins.IsGLESDevice = ins.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 ||
                ins.graphicsDeviceType == GraphicsDeviceType.OpenGLES3;
            ins.IsGLDevice = ins.IsGLESDevice ||
                ins.graphicsDeviceType == GraphicsDeviceType.OpenGLCore;
            ins.IsDX10 = ins.graphicsDeviceType == GraphicsDeviceType.Direct3D11 &&
                ins.graphicsShaderLevel <= 40;
            ins.activeColorSpace = QualitySettings.activeColorSpace;
            ins.preserveFramebufferAlpha = Graphics.preserveFramebufferAlpha;
            ins.usesReversedZBuffer = SystemInfo.usesReversedZBuffer;
            ins.nearClipZ = ins.usesReversedZBuffer ? 1 : -1;
            ins.graphicsUVStartsAtTop = SystemInfo.graphicsUVStartsAtTop;
            ins.isPlaying = Application.isPlaying;
            ins.hasHSRonGPU = SystemInfo.hasHiddenSurfaceRemovalOnGPU;
            ins.noFrontToBackOpaqueFlags = SortingCriteria.SortingLayer | SortingCriteria.RenderQueue |
                SortingCriteria.OptimizeStateChanges | SortingCriteria.CanvasOrder;
            ins.supportsShadows = SystemInfo.supportsShadows;

            //功能支持状态判断
            ins.ldrFormat = ins.activeColorSpace == ColorSpace.Linear ? //将低位颜色数据保存在Gamma空间可提高精度
                        GraphicsFormat.R8G8B8A8_SRGB : GraphicsFormat.R8G8B8A8_UNorm;
            ins.hdrFormat = SystemInfo.GetGraphicsFormat(DefaultFormat.HDR);
            if (!ins.preserveFramebufferAlpha && GlobalLogic.SupportsGraphicsFormat(GraphicsFormat.B10G11R11_UFloatPack32, FormatUsage.Linear | FormatUsage.Render))
                ins.hdrFormat = GraphicsFormat.B10G11R11_UFloatPack32;
            else if (GlobalLogic.SupportsGraphicsFormat(GraphicsFormat.R16G16B16A16_SFloat, FormatUsage.Linear | FormatUsage.Render))
                ins.hdrFormat = GraphicsFormat.R16G16B16A16_SFloat;

            ins.SystemSupporteDeferredRendering = !ins.IsGLDevice && !ins.IsDX10 && //支持NativeRenderPass api
                   ins.supportedRenderTargetCount >= GlobalData.DeferredRenderingNeedRenderTargetCount &&
                   ins.graphicsShaderLevel >= 45 && //必要的shader支持
                   GlobalLogic.SupportsGraphicsFormat(GlobalData.formatForPackedNormal, FormatUsage.Render); //必要的RT format支持

            ins.m_StencilDeferredMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.stencilDeferredPS);
            ins.m_BlitMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.coreBlitPS);

            ins.m_CopyDepthMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.copyDepthPS);
            ins.m_SamplingMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.samplingPS);
            ins.m_CameraMotionVecMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.cameraMotionVector);
            ins.m_ObjectMotionVecMaterial = CoreUtils.CreateEngineMaterial(asset.m_pipelineResources.objectMotionVector);

            ins.triangleMesh = new Mesh();
            ins.triangleMesh.vertices = GlobalLogic.GetFullScreenTriangleVertexPosition(ins.nearClipZ);
            ins.triangleMesh.uv = GlobalLogic.GetFullScreenTriangleTexCoord();
            ins.triangleMesh.triangles = new int[3] { 0, 1, 2 };
            ins.triangleMesh.hideFlags |= HideFlags.HideAndDontSave;
            ins.triangleMesh.UploadMeshData(true);
        }

        public void DisposePipelineResource()
        {
            var ins = GlobalData.Instance;
            CoreUtils.Destroy(ins.m_BlitMaterial);
            CoreUtils.Destroy(ins.m_CopyDepthMaterial);
            CoreUtils.Destroy(ins.m_SamplingMaterial);
            CoreUtils.Destroy(ins.m_StencilDeferredMaterial);
            CoreUtils.Destroy(ins.m_CameraMotionVecMaterial);
            CoreUtils.Destroy(ins.m_ObjectMotionVecMaterial);

            ins.m_ColorGradingLut?.Release();
            ins.m_DepthTexture?.Release();
            ins.m_OpaqueColor?.Release();
            ins.m_MotionVectorColor?.Release();
            ins.m_MotionVectorDepth?.Release();
            ins.m_NormalsTexture?.Release();
        }

        protected override void Dispose(bool disposing)
        {
            GlobalData.Instance.OnDispose?.Invoke(); //释放全局资源
            GlobalData.Instance.OnDispose = null;
            GlobalData.Instance = null;

            asset.DestroyRenderers(); //释放逐pass资源
            asset = null;

            SekiaPipeline.Instance = null;
            SekiaPipelineAsset.Instance = null;

            base.Dispose(disposing);

            Shader.globalRenderPipeline = "";
            SupportedRenderingFeatures.active = new SupportedRenderingFeatures();
            ShaderData.instance.Dispose();

#if UNITY_EDITOR
            UnityEditor.Rendering.Universal.SceneViewDrawMode.ResetDrawMode();
#endif
            Lightmapping.ResetDelegate();
        }

        protected override void Render(ScriptableRenderContext renderContext, Camera[] cameras)
        {
            Render(renderContext, new List<Camera>(cameras));
        }

        protected override void Render(ScriptableRenderContext renderContext, List<Camera> cameras)
        {
            //cmd为null：仅用于CPU性能分析 与DrawCall无关
            using var profScope = new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.UniversalRenderTotal));

            using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.BeginContextRendering")))
            {
                BeginContextRendering(renderContext, cameras);
            }

            GraphicsSettings.lightsUseLinearIntensity = (QualitySettings.activeColorSpace == ColorSpace.Linear);
            GraphicsSettings.lightsUseColorTemperature = true;
            GraphicsSettings.defaultRenderingLayerMask = UniversalRenderPipeline.k_DefaultRenderingLayerMask;
            SetupPerFrameShaderConstants();


            GlobalLogic.SortCameras(cameras);
            for (int i = 0; i < cameras.Count; ++i)
            {
                var camera = cameras[i];
                if (GlobalLogic.IsGameCamera(camera))
                {
                    RenderCameraStack(renderContext, camera);
                }
                else
                {
                    using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.BeginCameraRendering")))
                    {
                        BeginCameraRendering(renderContext, camera);
                    }
#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
                    //It should be called before culling to prepare material. When there isn't any VisualEffect component, this method has no effect.
                    UnityEngine.VFX.VFXManager.PrepareCamera(camera);
#endif
                    GlobalLogic.UpdateVolumeFramework(camera, null);

                    RenderSingleCameraInternal(renderContext, camera);

                    using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.EndCameraRendering")))
                    {
                        EndCameraRendering(renderContext, camera);
                    }
                }
            }

            using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.EndContextRendering")))
            {
                EndContextRendering(renderContext, cameras);
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
                context.ExecuteCommandBuffer(cmd); // Send all the commands enqueued so far in the CommandBuffer cmd, to the ScriptableRenderContext context
                cmd.Clear();

                //生成UGUI mesh
                {
#if UNITY_EDITOR
                    if (isSceneViewCamera)
                        ScriptableRenderContext.EmitWorldGeometryForSceneView(camera);
                    else
#endif
                    if (cameraData.camera.targetTexture != null && cameraData.cameraType != CameraType.Preview)
                        ScriptableRenderContext.EmitGeometryForCamera(camera);
                }

                //逐相机的裁剪 粗粒度过滤当前相机的可见目标
                //renderer.Clear(ref cameraData);
                renderer.SetupCullingParameters(ref cullingParameters, ref cameraData);
                var cullResults = context.Cull(ref cullingParameters);

                InitializeRenderingData(SekiaPipeline.Instance.asset, ref cameraData, ref cullResults, anyPostProcessingEnabled, cmd, out var renderingData);

                using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("ScriptableRenderer.Setup")))
                    renderer.Setup(context, ref renderingData);

                // Timing scope inside
                renderer.Execute(context, ref renderingData);
                CleanupLightData(ref renderingData.lightData);
            } // When ProfilingSample goes out of scope, an "EndSample" command is enqueued into CommandBuffer cmd

            context.ExecuteCommandBuffer(cmd); // Sends to ScriptableRenderContext all the commands enqueued since cmd.Clear, i.e the "EndSample" command
            CommandBufferPool.Release(cmd);

            using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("ScriptableRenderContext.Submit")))
            {
                if (renderer.useRenderPass && !context.SubmitForRenderPassValidation())
                {
                    renderer.useRenderPass = false;
                    CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.RenderPassEnabled, false);
                    Debug.LogWarning("Rendering command not supported inside a native RenderPass found. Falling back to non-RenderPass rendering path");
                }
                context.Submit(); // Actually execute the commands that we previously sent to the ScriptableRenderContext context
            }
        }

        //渲染整个栈 先Base相机 后Overlay相机
        static void RenderCameraStack(ScriptableRenderContext context, Camera baseCamera)
        {
            using var profScope = new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.RenderCameraStack));

            var ins = GlobalData.Instance;
            baseCamera.TryGetComponent<UniversalAdditionalCameraData>(out var baseCameraAdditionalData);

            if (baseCameraAdditionalData != null && baseCameraAdditionalData.renderType == CameraRenderType.Overlay)
                return;
            List<Camera> cameraStack = baseCameraAdditionalData?.m_Cameras;

            bool anyPostProcessingEnabled = baseCameraAdditionalData != null && baseCameraAdditionalData.renderPostProcessing;

            // We need to know the last active camera in the stack to be able to resolve
            // rendering to screen when rendering it. The last camera in the stack is not
            // necessarily the last active one as it users might disable it.
            int lastActiveOverlayCameraIndex = -1;
            if (cameraStack != null)
            {
                var baseCameraRendererType = SekiaPipeline.Instance.asset.GetRenderer(baseCameraAdditionalData.m_RendererIndex).GetType();
                bool shouldUpdateCameraStack = false;

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
            anyPostProcessingEnabled &= ins.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;

            bool isStackedRendering = lastActiveOverlayCameraIndex != -1;

            //开始渲染相机栈
            using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.BeginCameraRendering")))
            {
                BeginCameraRendering(context, baseCamera);
            }
            // Update volumeframework before initializing additional camera data
            GlobalLogic.UpdateVolumeFramework(baseCamera, baseCameraAdditionalData);
            InitializeCameraData(baseCamera, baseCameraAdditionalData, !isStackedRendering, out var baseCameraData);
            RenderTextureDescriptor originalTargetDesc = baseCameraData.cameraTargetDescriptor;

#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
            //It should be called before culling to prepare material. When there isn't any VisualEffect component, this method has no effect.
            VFX.VFXManager.PrepareCamera(baseCamera);
#endif
            RenderSingleCamera(context, ref baseCameraData, anyPostProcessingEnabled);
            using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.EndCameraRendering")))
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

                        using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.BeginCameraRendering")))
                        {
                            BeginCameraRendering(context, currCamera);
                        }
#if VISUAL_EFFECT_GRAPH_0_0_1_OR_NEWER
                        //It should be called before culling to prepare material. When there isn't any VisualEffect component, this method has no effect.
                        VFX.VFXManager.PrepareCamera(currCamera);
#endif
                        GlobalLogic.UpdateVolumeFramework(currCamera, currCameraData);
                        InitializeAdditionalCameraData(currCamera, currCameraData, lastCamera, ref overlayCameraData);

                        RenderSingleCamera(context, ref overlayCameraData, anyPostProcessingEnabled);

                        using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("Pipeline.EndCameraRendering")))
                        {
                            EndCameraRendering(context, currCamera);
                        }
                    }
                }
            }
        }

        static void InitializeCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool resolveFinalTarget, out CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.InitializeCameraData"));

            var ins = GlobalData.Instance;
            cameraData = new CameraData();
            InitializeStackedCameraData(camera, additionalCameraData, ref cameraData);
            InitializeAdditionalCameraData(camera, additionalCameraData, resolveFinalTarget, ref cameraData);

            int msaaSamples = 1;
            bool isSceneViewCamera = (camera.cameraType == CameraType.SceneView);
            float renderScale = isSceneViewCamera ? 1.0f : cameraData.renderScale;

            cameraData.cameraTargetDescriptor = GlobalLogic.CreateRenderTextureDescriptor(camera, renderScale,
                cameraData.isHdrEnabled, msaaSamples, ins);
        }

        //初始化全栈数据
        static void InitializeStackedCameraData(Camera baseCamera, UniversalAdditionalCameraData baseAdditionalCameraData, ref CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.InitializeStackedCameraData"));

            var ins = GlobalData.Instance;
            var settings = SekiaPipeline.Instance.asset;

            cameraData.needFirstClearRT = true;
            cameraData.needSetViewPort = true;
            cameraData.isTargetFlipped = false;

            cameraData.targetTexture = baseCamera.targetTexture;
            cameraData.cameraType = baseCamera.cameraType;
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
                cameraData.isStopNaNEnabled = baseAdditionalCameraData.stopNaN && ins.graphicsShaderLevel >= 35;
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

            cameraData.fsrOverrideSharpness = settings.fsrOverrideSharpness;
            cameraData.fsrSharpness = 0;

            bool canSkipFrontToBackSorting =
                (baseCamera.opaqueSortMode == OpaqueSortMode.Default && ins.hasHSRonGPU) ||
                baseCamera.opaqueSortMode == OpaqueSortMode.NoDistanceSort;

            cameraData.defaultOpaqueSortFlags = canSkipFrontToBackSorting ?
                ins.noFrontToBackOpaqueFlags : SortingCriteria.CommonOpaque;
        }

        //根据当前相机类型 得到适合BaseCamera和OverlayCamera的数据
        static void InitializeAdditionalCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool resolveFinalTarget, ref CameraData cameraData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.InitializeAdditionalCameraData"));

            var ins = GlobalData.Instance;
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
            }
            else if (additionalCameraData != null)
            {
                cameraData.renderType = additionalCameraData.renderType;
                cameraData.clearDepth = (additionalCameraData.renderType != CameraRenderType.Base) ? additionalCameraData.clearDepth : true;
                cameraData.postProcessEnabled = additionalCameraData.renderPostProcessing;
                cameraData.maxShadowDistance = (additionalCameraData.renderShadows) ? cameraData.maxShadowDistance : 0.0f;
                cameraData.renderer = SekiaPipeline.Instance.asset.GetRenderer(additionalCameraData.m_RendererIndex);
            }
            else
            {
                cameraData.renderType = CameraRenderType.Base;
                cameraData.clearDepth = true;
                cameraData.postProcessEnabled = false;
                cameraData.renderer = SekiaPipeline.Instance.asset.defaultRenderer;
            }

            // Disables post if GLes2
            cameraData.postProcessEnabled &= ins.graphicsDeviceType != GraphicsDeviceType.OpenGLES2;

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

            cameraData.viewMatrix = camera.worldToCameraMatrix;
            cameraData.projectionMatrix = projectionMatrix;

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
            cameraData.cameraNeedSetupForwardLight = true;
        }

        static void InitializeRenderingData(SekiaPipelineAsset settings, ref CameraData cameraData, ref CullingResults cullResults,
            bool anyPostProcessingEnabled, CommandBuffer cmd, out RenderingData renderingData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.InitializeRenderingData"));

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
            renderingData.perObjectData = GetPerObjectLightFlags(renderingData.lightData.additionalLightsCount > 0);
            renderingData.postProcessingEnabled = anyPostProcessingEnabled;
            renderingData.commandBuffer = cmd;
        }

        static void InitializeShadowData(SekiaPipelineAsset settings, NativeArray<VisibleLight> visibleLights, bool mainLightCastShadows, bool additionalLightsCastShadows, out ShadowData shadowData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.InitializeShadowData"));

            var ins = GlobalData.Instance;
            ins.m_ShadowBiasData.Clear();
            ins.m_ShadowResolutionData.Clear();

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
                    ins.m_ShadowBiasData.Add(new Vector4(light.shadowBias, light.shadowNormalBias, 0.0f, 0.0f));
                else
                    ins.m_ShadowBiasData.Add(new Vector4(settings.shadowDepthBias, settings.shadowNormalBias, 0.0f, 0.0f));

                if (data && (data.additionalLightsShadowResolutionTier == UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierCustom))
                {
                    ins.m_ShadowResolutionData.Add((int)light.shadowResolution); // native code does not clamp light.shadowResolution between -1 and 3
                }
                else if (data && (data.additionalLightsShadowResolutionTier != UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierCustom))
                {
                    int resolutionTier = Mathf.Clamp(data.additionalLightsShadowResolutionTier, UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierLow, UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierHigh);
                    ins.m_ShadowResolutionData.Add(settings.GetAdditionalLightsShadowResolution(resolutionTier));
                }
                else
                {
                    ins.m_ShadowResolutionData.Add(settings.GetAdditionalLightsShadowResolution(UniversalAdditionalLightData.AdditionalLightsShadowDefaultResolutionTier));
                }
            }

            shadowData.bias = ins.m_ShadowBiasData;
            shadowData.resolution = ins.m_ShadowResolutionData;
            shadowData.supportsMainLightShadows = ins.supportsShadows && settings.supportsMainLightShadows && mainLightCastShadows;

            // We no longer use screen space shadows in URP.
            // This change allows us to have particles & transparent objects receive shadows.
#pragma warning disable 0618
            shadowData.requiresScreenSpaceShadowResolve = false;
#pragma warning restore 0618

            // On GLES2 we strip the cascade keywords from the lighting shaders, so for consistency we force disable the cascades here too
            shadowData.mainLightShadowCascadesCount = ins.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 ? 1 : settings.shadowCascadeCount;
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

            shadowData.supportsAdditionalLightShadows = ins.supportsShadows && settings.supportsAdditionalLightShadows && additionalLightsCastShadows;
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
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.InitializeLightData"));

            var ins = GlobalData.Instance;
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
            lightData.supportsLightLayers = RenderingUtils.SupportsLightLayers(ins.graphicsDeviceType) && settings.useRenderingLayers;
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

        static PerObjectData GetPerObjectLightFlags(bool needPerObjectLightData)
        {
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.GetPerObjectLightFlags"));

            var configuration = PerObjectData.ReflectionProbes | PerObjectData.Lightmaps | PerObjectData.LightProbe | PerObjectData.LightData | PerObjectData.OcclusionProbe | PerObjectData.ShadowMask;

            if (needPerObjectLightData)
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
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.GetMainLightIndex"));

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
            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.SetupPerFrameShaderConstants"));

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
    }
}
