using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;

namespace Sekia
{
    public sealed class SekiaRenderer
    {
        //部分属性固化在Renderer上 CameraData保持Base相机固化数据的引用
        private GlobalData ins;
        private bool useIntermediateRT; //根据功能开启状态自动切换
        private bool useCopyColorRT; //根据功能开启状态或用户意图切换
        private bool useCopyDepthRT; //根据功能开启状态或用户意图切换
        private RenderTexture mainColorAttachment;
        private RenderTexture mainDepthAttachment;
        private RenderTexture copyColorAttachment;
        private RenderTexture copyDepthAttachment;

        public bool useRenderPass = false;
        public SekiaRendererData data;
        public Action OnDispose; //挂载子级pass的Dispose 用于释放RT等资源
        public List<SekiaRendererPass> activeRenderPassQueue = new List<SekiaRendererPass>(32);
        public List<SekiaRendererFeature> features_GameView = new List<SekiaRendererFeature>(10);
#if UNITY_EDITOR
        public List<SekiaRendererFeature> features_Sceneview = new List<SekiaRendererFeature>(10);
        public List<SekiaRendererFeature> features_Preview = new List<SekiaRendererFeature>(10);
#endif

        public SekiaRenderer(SekiaRendererData data)
        {
            ins = GlobalData.Instance;
            this.data = data;

            foreach (var feature in data.m_Features_Gameview)
            {
                if (feature == null)
                    continue;
                feature.Init();
                features_GameView.Add(feature);
            }

#if UNITY_EDITOR
            foreach (var feature in data.m_Features_Sceneview)
            {
                if (feature == null)
                    continue;
                feature.Init();
                features_Sceneview.Add(feature);
            }

            foreach (var feature in data.m_Features_Preview)
            {
                if (feature == null)
                    continue;
                feature.Init();
                features_Preview.Add(feature);
            }
#endif

            activeRenderPassQueue.Clear();
        }

        //Clear → SetupCullingParameters → Setup → Execute → StackFinishRendering
        public void SetupCullingParameters(ref ScriptableCullingParameters cullingParameters, ref CameraData cameraData)
        {
            bool isShadowCastingDisabled = !SekiaPipeline.Instance.asset.supportsMainLightShadows && !SekiaPipeline.Instance.asset.supportsAdditionalLightShadows;
            bool isShadowDistanceZero = Mathf.Approximately(cameraData.maxShadowDistance, 0.0f);
            if (isShadowCastingDisabled || isShadowDistanceZero)
            {
                cullingParameters.cullingOptions &= ~CullingOptions.ShadowCasters;
            }

            if (useRenderPass)
                cullingParameters.maximumVisibleLights = 0xFFFF;
            else
                cullingParameters.maximumVisibleLights = UniversalRenderPipeline.maxVisibleAdditionalLights + 1; //Cull并不会判断光源是否包含主光源

            cullingParameters.shadowDistance = cameraData.maxShadowDistance;
            cullingParameters.conservativeEnclosingSphere = SekiaPipeline.Instance.asset.conservativeEnclosingSphere;
            cullingParameters.numIterationsEnclosingSphere = SekiaPipeline.Instance.asset.numIterationsEnclosingSphere;
        }

        public void Setup(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;

            if (cameraData.renderType == CameraRenderType.Base)
            {
                //初始化栈的渲染状态
                this.useRenderPass = data.useRenderPass &&
                    GlobalData.Instance.SystemSupporteDeferredRendering &&
                    !GL.wireframe &&
                    cameraData.isRenderPassSupportedCamera;

                //特定功能需要开启中间RT
                if (this.useRenderPass)
                    this.useIntermediateRT = data.useIntermediateRT;

                this.useCopyColorRT = data.useCopyColorRT;
                this.useCopyDepthRT = data.useCopyDepthRT;

                if (cameraData.renderType == CameraRenderType.Base &&
                    GlobalData.Instance.graphicsUVStartsAtTop &&
                    this.useIntermediateRT)
                    cameraData.isTargetFlipped = true;

                var cmd = renderingData.commandBuffer;

                if (useIntermediateRT)
                {
                    var colorDesc = cameraData.cameraTargetDescriptor;
                    colorDesc.useMipMap = false;
                    colorDesc.autoGenerateMips = false;
                    colorDesc.depthBufferBits = (int)DepthBits.None;
                    GlobalLogic.ReAllocateRenderTextureIfNeeded(ref mainColorAttachment,
                       in colorDesc, FilterMode.Bilinear, TextureWrapMode.Clamp, name: "_MainColor");

                    var depthDesc = cameraData.cameraTargetDescriptor;
                    depthDesc.useMipMap = false;
                    depthDesc.autoGenerateMips = false;
                    depthDesc.bindMS = false;
                    depthDesc.graphicsFormat = GraphicsFormat.None;
                    depthDesc.depthStencilFormat = GlobalData.k_DepthStencilFormat;
                    GlobalLogic.ReAllocateRenderTextureIfNeeded(ref mainDepthAttachment,
                        depthDesc, FilterMode.Point, TextureWrapMode.Clamp, name: "_MainDepth");
                }
                else
                {
                    if (mainColorAttachment != null)
                    {
                        mainColorAttachment.Release();
                        mainColorAttachment = null;
                    }

                    if (mainDepthAttachment != null)
                    {
                        mainDepthAttachment.Release();
                        mainDepthAttachment = null;
                    }
                }

                if (useCopyColorRT)
                {
                    //声明CopyColor
                }
                else if (this.copyColorAttachment != null)
                {
                    this.copyDepthAttachment.Release();
                    this.copyDepthAttachment = null;
                }

                if (useCopyDepthRT)
                {
                    //声明CopuDepth
                }
                else if (this.copyDepthAttachment != null)
                {
                    this.copyDepthAttachment.Release();
                    this.copyDepthAttachment = null;
                }

                //将Base相机的数据传递给栈
                cameraData.useIntermediateRT = this.useIntermediateRT;
                cameraData.mainColorAttachment = this.mainColorAttachment;
                cameraData.mainDepthAttachment = this.mainDepthAttachment;

                cameraData.useCopyColorRT = this.useCopyColorRT;
                cameraData.copyColorAttachment = this.copyColorAttachment;

                cameraData.useCopyDepthRT = this.useCopyDepthRT;
                cameraData.copyDepthAttachment = this.copyDepthAttachment;

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }
        }

        public void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;
            Camera camera = cameraData.camera;
            var cmd = renderingData.commandBuffer;
            var ins = GlobalData.Instance;

            //参考：AddRenderPasses
            //Feature的AddRenderPasses
            {
                using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaRenderer.AddRenderPasses"));

#if UNITY_EDITOR
                if (cameraData.cameraType == CameraType.SceneView)
                {
                    for (int i = 0; i < features_Sceneview.Count; ++i)
                    {
                        if (!features_Sceneview[i].isActive)
                            continue;
                        features_Sceneview[i].AddRenderPasses(this, ref renderingData);
                    }
                }
                else if (cameraData.cameraType == CameraType.Preview)
                {
                    for (int i = 0; i < features_Preview.Count; ++i)
                    {
                        if (!features_Preview[i].isActive)
                            continue;
                        features_Preview[i].AddRenderPasses(this, ref renderingData);
                    }
                }
                else
#endif
                {
                    for (int i = 0; i < features_GameView.Count; ++i)
                    {
                        if (!features_GameView[i].isActive)
                            continue;
                        features_GameView[i].AddRenderPasses(this, ref renderingData);
                    }
                }

#if UNITY_EDITOR
                int count = activeRenderPassQueue.Count;
                for (int i = count - 1; i >= 0; i--)
                {
                    if (activeRenderPassQueue[i] == null)
                    {
                        activeRenderPassQueue.RemoveAt(i);
                        Debug.LogError("RenderFeature列表中包含null项");
                    }
                }
#endif
            }

            //参考：ClearRenderingState
            {
                using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaRenderer.ClearRenderingState"));
                {
                    // Reset per-camera shader keywords. They are enabled depending on which render passes are executed.
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.MainLightShadows);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.MainLightShadowCascades);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightsVertex);
                    cmd.DisableShaderKeyword(ShaderKeywordStrings.AdditionalLightsPixel);
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

            //逐相机参数设置
            {
                using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaRenderer.SetupCamera")))
                {

                    bool isTargetFlipped = ins.graphicsUVStartsAtTop && this.useIntermediateRT;

                    float scaledCameraWidth = (float)cameraData.cameraTargetDescriptor.width;
                    float scaledCameraHeight = (float)cameraData.cameraTargetDescriptor.height;
                    float cameraWidth = (float)camera.pixelWidth;
                    float cameraHeight = (float)camera.pixelHeight;

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

                    if (ins.usesReversedZBuffer)
                    {
                        zBufferParams.y += zBufferParams.x;
                        zBufferParams.x = -zBufferParams.x;
                        zBufferParams.w += zBufferParams.z;
                        zBufferParams.z = -zBufferParams.z;
                    }

                    // Projection flip sign logic is very deep in GfxDevice::SetInvertProjectionMatrix
                    // This setup is tailored especially for overlay camera game view
                    // For other scenarios this will be overwritten correctly by SetupCameraProperties
                    float projectionFlipSign = isTargetFlipped ? -1.0f : 1.0f;
                    Vector4 projectionParams = new Vector4(projectionFlipSign, near, far, 1.0f * invFar);
                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._ProjectionParams, projectionParams);

                    Vector4 orthoParams = new Vector4(camera.orthographicSize * cameraData.aspectRatio, camera.orthographicSize, 0.0f, isOrthographic);

                    // Camera and Screen variables as described in https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._WorldSpaceCameraPos, cameraData.worldSpaceCameraPos);
                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._ScreenParams, new Vector4(cameraWidth, cameraHeight, 1.0f + 1.0f / cameraWidth, 1.0f + 1.0f / cameraHeight));
                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._ScaledScreenParams, new Vector4(scaledCameraWidth, scaledCameraHeight, 1.0f + 1.0f / scaledCameraWidth, 1.0f + 1.0f / scaledCameraHeight));
                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._ZBufferParams, zBufferParams);
                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs.unity_OrthoParams, orthoParams);

                    cmd.SetGlobalVector(GlobalData.ShaderPropertyIDs._ScreenSize, new Vector4(cameraWidth, cameraHeight, 1.0f / cameraWidth, 1.0f / cameraHeight));
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            //Pass的Execute
            foreach (var pass in activeRenderPassQueue)
            {
                pass.Execute(context, ref renderingData);
            }

            //bool drawGizmos = UniversalRenderPipelineDebugDisplaySettings.Instance.renderingSettings.sceneOverrideMode == DebugSceneOverrideMode.None;
            //if(drawGizmos)
            //插个pass做这个
            GlobalLogic.DrawGizmos(context, camera, GizmoSubset.PreImageEffects, ref renderingData);
            GlobalLogic.DrawWireOverlay(context, camera);
            GlobalLogic.DrawGizmos(context, camera, GizmoSubset.PostImageEffects, ref renderingData);

            //参考InternalFinishRendering
            //Pass的FrameCleanup和OnFinishCameraStackRendering
            {
                using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaRenderer.InternalFinishRendering")))
                {
                    for (int i = 0; i < activeRenderPassQueue.Count; ++i)
                        activeRenderPassQueue[i].OnCameraCleanup(cmd);

                    if (cameraData.resolveFinalTarget)
                        StackFinishRendering();

                    activeRenderPassQueue.Clear();
                }

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

        }

        public void StackFinishRendering()
        {
        }
    }

    [ExcludeFromPreset]
    public abstract class SekiaRendererFeature : ScriptableObject
    {
        [SerializeField, HideInInspector] public bool isActive = true;

#if UNITY_EDITOR
        [NonSerialized]
        bool isSecondInit = false; //仅用于编辑器下修改属性时快速更新

        void OnValidate()
        {
            if (isSecondInit)
                Init();
            if (!isSecondInit)
                isSecondInit = true;
        }
#endif

        public abstract void Init();

        public abstract void AddRenderPasses(SekiaRenderer renderer, ref RenderingData renderingData);


    }

    public abstract class SekiaRendererPass
    {
        public abstract void OnCameraCleanup(CommandBuffer cmd);

        public abstract void Execute(ScriptableRenderContext context, ref RenderingData renderingData);
    }
}
