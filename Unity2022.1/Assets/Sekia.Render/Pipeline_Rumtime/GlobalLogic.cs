
using UnityEngine;
using UnityEngine.Rendering;
using System;
using Unity.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Experimental.Rendering;
using LightDataGI = UnityEngine.Experimental.GlobalIllumination.LightDataGI;
using Lightmapping = UnityEngine.Experimental.GlobalIllumination.Lightmapping;
using LightmapperUtils = UnityEngine.Experimental.GlobalIllumination.LightmapperUtils;
using Cookie = UnityEngine.Experimental.GlobalIllumination.Cookie;
using DirectionalLight = UnityEngine.Experimental.GlobalIllumination.DirectionalLight;
using PointLight = UnityEngine.Experimental.GlobalIllumination.PointLight;
using SpotLight = UnityEngine.Experimental.GlobalIllumination.SpotLight;
using RectangleLight = UnityEngine.Experimental.GlobalIllumination.RectangleLight;
using DiscLight = UnityEngine.Experimental.GlobalIllumination.DiscLight;
using AngularFalloffType = UnityEngine.Experimental.GlobalIllumination.AngularFalloffType;
using LightMode = UnityEngine.Experimental.GlobalIllumination.LightMode;
using FalloffType = UnityEngine.Experimental.GlobalIllumination.FalloffType;

namespace Sekia
{
    public static class GlobalLogic
    {
        public static bool SupportsGraphicsFormat(GraphicsFormat format, FormatUsage usage)
        {
            bool support;
            if (!GlobalData.graphicsFormatSupport.TryGetValue(format, out var uses))
            {
                uses = new Dictionary<FormatUsage, bool>();
                support = SystemInfo.IsFormatSupported(format, usage);
                uses.Add(usage, support);
                GlobalData.graphicsFormatSupport.Add(format, uses);
            }
            else
            {
                if (!uses.TryGetValue(usage, out support))
                {
                    support = SystemInfo.IsFormatSupported(format, usage);
                    uses.Add(usage, support);
                }
            }

            return support;
        }

        public static RenderTextureDescriptor CreateRenderTextureDescriptor(Camera camera, float renderScale,
              bool isHdrEnabled, int msaaSamples, GlobalData ins)
        {
            RenderTextureDescriptor desc;

            if (camera.targetTexture == null)
            {
                desc = new RenderTextureDescriptor(camera.pixelWidth, camera.pixelHeight);
                desc.width = Mathf.RoundToInt(desc.width * renderScale);
                desc.height = Mathf.RoundToInt(desc.height * renderScale);
                desc.graphicsFormat = isHdrEnabled ? ins.hdrFormat : ins.ldrFormat;
                desc.depthBufferBits = 32;
                desc.msaaSamples = msaaSamples;
                desc.sRGB = (ins.activeColorSpace == ColorSpace.Linear);
            }
            else
            {
                desc = camera.targetTexture.descriptor;
                desc.width = camera.pixelWidth;
                desc.height = camera.pixelHeight;
                if (camera.cameraType == CameraType.SceneView && !isHdrEnabled)
                    desc.graphicsFormat = ins.ldrFormat;
            }

            // Make sure dimension is non zero
            desc.width = Mathf.Max(1, desc.width);
            desc.height = Mathf.Max(1, desc.height);

            desc.enableRandomWrite = false;
            desc.bindMS = false;
            desc.useDynamicScale = camera.allowDynamicResolution;
            return desc;
        }


        #region 烘培Lightmap委托
        public static Lightmapping.RequestLightsDelegate lightsDelegate = (Light[] requests, NativeArray<LightDataGI> lightsOutput) =>
        {
            LightDataGI lightData = new LightDataGI();
#if UNITY_EDITOR
            // Always extract lights in the Editor.
            for (int i = 0; i < requests.Length; i++)
            {
                Light light = requests[i];
                var additionalLightData = light.GetUniversalAdditionalLightData();

                LightmapperUtils.Extract(light, out Cookie cookie);

                switch (light.type)
                {
                    case LightType.Directional:
                        DirectionalLight directionalLight = new DirectionalLight();
                        LightmapperUtils.Extract(light, ref directionalLight);

                        if (light.cookie != null)
                        {
                            // Size == 1 / Scale
                            cookie.sizes = additionalLightData.lightCookieSize;
                            // Offset, Map cookie UV offset to light position on along local axes.
                            if (additionalLightData.lightCookieOffset != Vector2.zero)
                            {
                                var r = light.transform.right * additionalLightData.lightCookieOffset.x;
                                var u = light.transform.up * additionalLightData.lightCookieOffset.y;
                                var offset = r + u;

                                directionalLight.position += offset;
                            }
                        }

                        lightData.Init(ref directionalLight, ref cookie);
                        break;
                    case LightType.Point:
                        PointLight pointLight = new PointLight();
                        LightmapperUtils.Extract(light, ref pointLight);
                        lightData.Init(ref pointLight, ref cookie);
                        break;
                    case LightType.Spot:
                        SpotLight spotLight = new SpotLight();
                        LightmapperUtils.Extract(light, ref spotLight);
                        spotLight.innerConeAngle = light.innerSpotAngle * Mathf.Deg2Rad;
                        spotLight.angularFalloff = AngularFalloffType.AnalyticAndInnerAngle;
                        lightData.Init(ref spotLight, ref cookie);
                        break;
                    case LightType.Area:
                        RectangleLight rectangleLight = new RectangleLight();
                        LightmapperUtils.Extract(light, ref rectangleLight);
                        rectangleLight.mode = LightMode.Baked;
                        lightData.Init(ref rectangleLight);
                        break;
                    case LightType.Disc:
                        DiscLight discLight = new DiscLight();
                        LightmapperUtils.Extract(light, ref discLight);
                        discLight.mode = LightMode.Baked;
                        lightData.Init(ref discLight);
                        break;
                    default:
                        lightData.InitNoBake(light.GetInstanceID());
                        break;
                }

                lightData.falloff = FalloffType.InverseSquared;
                lightsOutput[i] = lightData;
            }
#else
            // If Enlighten realtime GI isn't active, we don't extract lights.
            if (SupportedRenderingFeatures.active.enlighten == false || ((int)SupportedRenderingFeatures.active.lightmapBakeTypes | (int)LightmapBakeType.Realtime) == 0)
            {
                for (int i = 0; i < requests.Length; i++)
                {
                    Light light = requests[i];
                    lightData.InitNoBake(light.GetInstanceID());
                    lightsOutput[i] = lightData;
                }
            }
            else
            {
                for (int i = 0; i < requests.Length; i++)
                {
                    Light light = requests[i];
                    switch (light.type)
                    {
                        case LightType.Directional:
                            DirectionalLight directionalLight = new DirectionalLight();
                            LightmapperUtils.Extract(light, ref directionalLight);
                            lightData.Init(ref directionalLight);
                            break;
                        case LightType.Point:
                            PointLight pointLight = new PointLight();
                            LightmapperUtils.Extract(light, ref pointLight);
                            lightData.Init(ref pointLight);
                            break;
                        case LightType.Spot:
                            SpotLight spotLight = new SpotLight();
                            LightmapperUtils.Extract(light, ref spotLight);
                            spotLight.innerConeAngle = light.innerSpotAngle * Mathf.Deg2Rad;
                            spotLight.angularFalloff = AngularFalloffType.AnalyticAndInnerAngle;
                            lightData.Init(ref spotLight);
                            break;
                        case LightType.Area:
                            // Rect area light is baked only in URP.
                            lightData.InitNoBake(light.GetInstanceID());
                            break;
                        case LightType.Disc:
                            // Disc light is baked only.
                            lightData.InitNoBake(light.GetInstanceID());
                            break;
                        default:
                            lightData.InitNoBake(light.GetInstanceID());
                            break;
                    }
                    lightData.falloff = FalloffType.InverseSquared;
                    lightsOutput[i] = lightData;
                }
            }
#endif
        };
        #endregion

        public static void SetSupportedRenderingFeatures()
        {
#if UNITY_EDITOR
            SupportedRenderingFeatures.active = new SupportedRenderingFeatures()
            {
                reflectionProbeModes = SupportedRenderingFeatures.ReflectionProbeModes.None, //反射探针不支持旋转
                defaultMixedLightingModes = SupportedRenderingFeatures.LightmapMixedBakeModes.Subtractive,
                mixedLightingModes = SupportedRenderingFeatures.LightmapMixedBakeModes.Subtractive | SupportedRenderingFeatures.LightmapMixedBakeModes.IndirectOnly | SupportedRenderingFeatures.LightmapMixedBakeModes.Shadowmask,
                lightmapBakeTypes = LightmapBakeType.Realtime, //关闭baked模式 mixed模式
                lightmapsModes = LightmapsMode.NonDirectional, //关闭Directional贴图
                lightProbeProxyVolumes = false,
                motionVectors = false,
                receiveShadows = false,
                reflectionProbes = false,
                reflectionProbesBlendDistance = true,
                particleSystemInstancing = true
            };
            UnityEditor.Rendering.Universal.SceneViewDrawMode.SetupDrawMode();
#endif
        }

        //由多个不同VolumeMask的Volume形成场景内的Volume矩阵
        //当相机移动并穿过不同区域时后处理参数发生渐变
        public static void UpdateVolumeFramework(Camera camera, UniversalAdditionalCameraData data)
        {
            void GetVolumeLayerMaskAndTrigger(Camera camera, UniversalAdditionalCameraData data, out LayerMask layerMask, out Transform trigger)
            {
                layerMask = 1; // "Default" 当相机没有挂载data组件时
                trigger = camera.transform;

                if (data != null)
                {
                    layerMask = data.volumeLayerMask;
                    trigger = (data.volumeTrigger != null) ? data.volumeTrigger : trigger;
                }
                else if (camera.cameraType == CameraType.SceneView)
                {
                    var mainCamera = Camera.main;  //SceneView相机尝试映射到主相机
                    UniversalAdditionalCameraData mainData = null;

                    if (mainCamera != null && mainCamera.TryGetComponent(out mainData))
                        layerMask = mainData.volumeLayerMask;
                    trigger = (mainData != null && mainData.volumeTrigger != null) ? mainData.volumeTrigger : trigger;
                }
            }

            bool RequiresVolumeFrameworkUpdate(UniversalAdditionalCameraData data)
            {
                VolumeFrameworkUpdateMode cameraVolumeFrameworkUpdateModeOption = data.m_VolumeFrameworkUpdateModeOption;
                if (cameraVolumeFrameworkUpdateModeOption == VolumeFrameworkUpdateMode.UsePipelineSettings)
                    return true;
                return cameraVolumeFrameworkUpdateModeOption == VolumeFrameworkUpdateMode.EveryFrame;
            }

            using var profScope = new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaPipeline.UpdateVolumeFramework"));

            bool shouldUpdate = camera.cameraType == CameraType.SceneView;
            shouldUpdate |= data != null && RequiresVolumeFrameworkUpdate(data);

#if UNITY_EDITOR
            shouldUpdate |= Application.isPlaying == false;
#endif

            //这个相机主动关闭了Volume更新 仅更新一次Volume
            if (!shouldUpdate && data)
            {
                if (data.volumeStack == null)
                {
                    data.volumeStack = VolumeManager.instance.CreateStack();
                    GetVolumeLayerMaskAndTrigger(camera, data, out LayerMask layerMask1, out Transform trigger1);
                    VolumeManager.instance.Update(data.volumeStack, trigger1, layerMask1);
                }

                VolumeManager.instance.stack = data.volumeStack;
                return;
            }

            //频繁更新Volume的相机不需要缓存VolumeStake
            if (data && data.volumeStack != null)
            {
                data.volumeStack.Dispose();
                data.volumeStack = null;
            }

            // Get the mask + trigger and update the stack
            GetVolumeLayerMaskAndTrigger(camera, data, out LayerMask layerMask, out Transform trigger);
            VolumeManager.instance.ResetMainStack();
            VolumeManager.instance.Update(trigger, layerMask);
        }

        //只有Game类型的Camera会被用户主动配置additionalCameraData
        public static bool IsGameCamera(Camera camera)
        {
            if (camera == null)
                throw new ArgumentNullException("camera");
            return camera.cameraType == CameraType.Game || camera.cameraType == CameraType.VR;
        }

        #region 相机深度排序
        private static Comparison<Camera> cameraComparison = (camera1, camera2) => { return (int)camera1.depth - (int)camera2.depth; };

#if UNITY_2021_1_OR_NEWER
        public static void SortCameras(List<Camera> cameras)
        {
            if (cameras.Count > 1)
                cameras.Sort(cameraComparison);
        }
#else
        public static void SortCameras(Camera[] cameras)
        {
            if (cameras.Length > 1)
                Array.Sort(cameras, cameraComparison);
        }
#endif
        #endregion

        #region 声明RenderTexture
        private static string GetRenderTargetAutoName(int width, int height, int depth, string format, TextureDimension dim, string name,
            bool mips = false, bool enableMSAA = false, MSAASamples msaaSamples = MSAASamples.None)
        {
            string result = string.Format("{0}_{1}x{2}", name, width, height);

            if (depth > 1)
                result = string.Format("{0}x{1}", result, depth);

            if (mips)
                result = string.Format("{0}_{1}", result, "Mips");

            result = string.Format("{0}_{1}", result, format);

            if (dim != TextureDimension.None)
                result = string.Format("{0}_{1}", result, dim);

            if (enableMSAA)
                result = string.Format("{0}_{1}", result, msaaSamples.ToString());

            return result;
        }

        public static void DestroyUnityObjectSafely(this UnityEngine.Object obj)
        {
            if (obj != null)
            {
#if UNITY_EDITOR
                if (Application.isPlaying && !UnityEditor.EditorApplication.isPaused)
                    UnityEngine.Object.Destroy(obj);
                else
                    UnityEngine.Object.DestroyImmediate(obj);
#else
                UnityEngine.Object.Destroy(obj);
#endif
            }
        }

        public static bool ReAllocateRenderTextureIfNeeded(
            ref RenderTexture rt, in RenderTextureDescriptor descriptor,
            FilterMode filterMode = FilterMode.Point, TextureWrapMode wrapMode = TextureWrapMode.Repeat,
            bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0, string name = "")
        {
            if (rt == null || rt.width != descriptor.width || rt.height != descriptor.height ||
                rt.descriptor.depthBufferBits != descriptor.depthBufferBits ||
                 (rt.descriptor.depthBufferBits == (int)DepthBits.None && !isShadowMap && rt.descriptor.graphicsFormat != descriptor.graphicsFormat) ||
                rt.descriptor.dimension != descriptor.dimension ||
                rt.descriptor.enableRandomWrite != descriptor.enableRandomWrite ||
                rt.descriptor.useMipMap != descriptor.useMipMap ||
                rt.descriptor.autoGenerateMips != descriptor.autoGenerateMips ||
                rt.descriptor.msaaSamples != descriptor.msaaSamples ||
                rt.descriptor.bindMS != descriptor.bindMS ||
                rt.descriptor.useDynamicScale != descriptor.useDynamicScale ||
                rt.descriptor.memoryless != descriptor.memoryless ||
                rt.filterMode != filterMode ||
                rt.wrapMode != wrapMode ||
                rt.anisoLevel != anisoLevel ||
                rt.mipMapBias != mipMapBias)
            {
                if (rt != null)
                    rt.DestroyUnityObjectSafely();

                rt = AllocRenderTexture(descriptor, filterMode, wrapMode, isShadowMap, anisoLevel, mipMapBias, name);
                return true;
            }
            return false;
        }

        private static RenderTexture AllocRenderTexture(in RenderTextureDescriptor descriptor,
            FilterMode filterMode = FilterMode.Point, TextureWrapMode wrapMode = TextureWrapMode.Repeat,
            bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0, string name = ""
        )
        {
            var result = AllocRenderTexture(descriptor.width, descriptor.height, descriptor.volumeDepth,
                (DepthBits)descriptor.depthBufferBits, descriptor.graphicsFormat,
                filterMode, wrapMode,
                descriptor.dimension, descriptor.enableRandomWrite,
                descriptor.useMipMap, descriptor.autoGenerateMips,
                isShadowMap, anisoLevel, mipMapBias,
                (MSAASamples)descriptor.msaaSamples, descriptor.bindMS,
                descriptor.memoryless, descriptor.vrUsage,
                name
            );
            return result;
        }

        private static RenderTexture AllocRenderTexture(int width, int height, int slices = 1, //RT数组的长度为1
            DepthBits depthBufferBits = DepthBits.None, GraphicsFormat colorFormat = GraphicsFormat.R8G8B8A8_SRGB,
            FilterMode filterMode = FilterMode.Point, TextureWrapMode wrapMode = TextureWrapMode.Repeat,
            TextureDimension dimension = TextureDimension.Tex2D, bool enableRandomWrite = false,
            bool useMipMap = false, bool autoGenerateMips = true,
            bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0f,
            MSAASamples msaaSamples = MSAASamples.None, bool bindTextureMS = false,
            RenderTextureMemoryless memoryless = RenderTextureMemoryless.None, VRTextureUsage vrUsage = VRTextureUsage.None,
            string name = ""
        )
        {
            bool enableMSAA = msaaSamples != MSAASamples.None;
            if (!enableMSAA && bindTextureMS == true)
            {
                Debug.LogWarning("RT没有开启MSAA但是开启了bindMS 强制bindMS为false");
                bindTextureMS = false;
            }

            //目前深度buffer不需要用到GraphicsFormat
            //GraphicsFormat中没有定义深度buffer格式
            RenderTexture rt;
            if (isShadowMap || depthBufferBits != DepthBits.None)
            {
                RenderTextureFormat format = isShadowMap ? RenderTextureFormat.Shadowmap : RenderTextureFormat.Depth;
                rt = new RenderTexture(width, height, (int)depthBufferBits, format, RenderTextureReadWrite.Linear)
                {
                    hideFlags = HideFlags.HideAndDontSave,
                    volumeDepth = slices,
                    filterMode = filterMode,
                    wrapMode = wrapMode,
                    dimension = dimension,
                    enableRandomWrite = enableRandomWrite,
                    useMipMap = useMipMap,
                    autoGenerateMips = autoGenerateMips,
                    anisoLevel = anisoLevel,
                    mipMapBias = mipMapBias,
                    antiAliasing = (int)msaaSamples,
                    bindTextureMS = bindTextureMS,
                    useDynamicScale = false, //强制关闭了动态分辨率
                    memorylessMode = memoryless,
                    vrUsage = vrUsage,
                    name = GlobalLogic.GetRenderTargetAutoName(width, height, slices, format.ToString(), dimension, name,
                        useMipMap, enableMSAA, msaaSamples)
                };
            }
            else
            {
                rt = new RenderTexture(width, height, (int)depthBufferBits, colorFormat)
                {
                    hideFlags = HideFlags.HideAndDontSave,
                    volumeDepth = slices,
                    filterMode = filterMode,
                    wrapMode = wrapMode,
                    dimension = dimension,
                    enableRandomWrite = enableRandomWrite,
                    useMipMap = useMipMap,
                    autoGenerateMips = autoGenerateMips,
                    anisoLevel = anisoLevel,
                    mipMapBias = mipMapBias,
                    antiAliasing = (int)msaaSamples,
                    bindTextureMS = bindTextureMS,
                    useDynamicScale = false, //强制关闭了动态分辨率
                    memorylessMode = memoryless,
                    vrUsage = vrUsage,
                    name = GlobalLogic.GetRenderTargetAutoName(width, height, slices, colorFormat.ToString(), dimension, name,
                        useMipMap, enableMSAA, msaaSamples)
                };
            }
            rt.Create();

            return rt;
        }
        #endregion

        public static unsafe ref T UnsafeElementAtMutable<T>(this NativeArray<T> array, int index) where T : struct
        {
            return ref UnsafeUtility.ArrayElementAsRef<T>(array.GetUnsafePtr(), index);
        }

        public static void ResetCameraMatrices(CommandBuffer cmd, ref CameraData cameraData, Matrix4x4 viewMatrix, Matrix4x4 projectionMatrix)
        {
            cmd.SetViewport(cameraData.pixelRect);

            cmd.SetViewProjectionMatrices(viewMatrix, projectionMatrix);
            Matrix4x4 gpuProjectionMatrix = GL.GetGPUProjectionMatrix(projectionMatrix, cameraData.isTargetFlipped);
            //Matrix4x4 viewAndProjectionMatrix = gpuProjectionMatrix * viewMatrix;
            //cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_MatrixV, viewMatrix);
            //cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.glstate_matrix_projection, gpuProjectionMatrix);
            //cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_MatrixVP, viewAndProjectionMatrix);

            Matrix4x4 inverseViewMatrix = Matrix4x4.Inverse(viewMatrix);
            Matrix4x4 inverseProjectionMatrix = Matrix4x4.Inverse(gpuProjectionMatrix);
            Matrix4x4 inverseViewProjection = inverseViewMatrix * inverseProjectionMatrix;
            Matrix4x4 worldToCameraMatrix = Matrix4x4.Scale(new Vector3(1.0f, 1.0f, -1.0f)) * viewMatrix;
            Matrix4x4 cameraToWorldMatrix = worldToCameraMatrix.inverse;
            cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_MatrixInvV, inverseViewMatrix);
            cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_MatrixInvP, inverseProjectionMatrix);
            cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_MatrixInvVP, inverseViewProjection);
            cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_WorldToCamera, worldToCameraMatrix);
            cmd.SetGlobalMatrix(GlobalData.ShaderPropertyIDs.unity_CameraToWorld, cameraToWorldMatrix);

            cameraData.needSetViewPort = false;
        }

        public static void ResetDefaultRenderTarget(CommandBuffer cmd, SekiaRenderer renderer, ref CameraData cameraData, GlobalData ins)
        {
            //设置渲染目标
            //第一次对某个目标进行渲染时可以不load内容 不清理颜色 选择性清理深度
            //第二次开始需要load内容
            if (cameraData.useIntermediateRT)
            {
#if UNITY_EDITOR
                Debug.Assert(cameraData.mainColorAttachment != null && cameraData.mainDepthAttachment != null);
                int cw = cameraData.mainColorAttachment.width;
                int ch = cameraData.mainColorAttachment.height;
                int dw = cameraData.mainDepthAttachment.width;
                int dh = cameraData.mainDepthAttachment.height;
                Debug.Assert(cw == dw && ch == dh);
#endif

                RenderTargetIdentifier colorTarget = cameraData.mainColorAttachment;
                RenderTargetIdentifier depthTarget = cameraData.mainDepthAttachment;

                if (ins.activeColorTarget == colorTarget &&
                    ins.activeDepthTarget == depthTarget &&
                    cameraData.needFirstClearRT)
                {
                    cameraData.needFirstClearRT = false;
                    var clearFlag = GlobalLogic.GetCameraClearFlag(ref cameraData);
                    if (clearFlag != RTClearFlags.None)
                        cmd.ClearRenderTarget(clearFlag, cameraData.backgroundColor, 1.0f, 0u);

                }
                else if (ins.activeColorTarget != colorTarget ||
                      ins.activeDepthTarget != depthTarget)
                {
                    ins.activeColorTarget = colorTarget;
                    ins.activeDepthTarget = depthTarget;

                    var loadAction = RenderBufferLoadAction.Load;
                    var clearFlag = RTClearFlags.None;
                    if (cameraData.needFirstClearRT)
                    {
                        loadAction = RenderBufferLoadAction.DontCare;
                        clearFlag = GlobalLogic.GetCameraClearFlag(ref cameraData);
                        cameraData.needFirstClearRT = false;
                    }

                    RenderTargetIdentifier colorBuffer = new RenderTargetIdentifier(colorTarget, 0, CubemapFace.Unknown, -1);
                    RenderTargetIdentifier depthBuffer = new RenderTargetIdentifier(depthTarget, 0, CubemapFace.Unknown, -1);
                    cmd.SetRenderTarget(colorBuffer, loadAction, RenderBufferStoreAction.Store,
                        depthBuffer, loadAction, RenderBufferStoreAction.Store);

                    if (clearFlag != RTClearFlags.None)
                        cmd.ClearRenderTarget(clearFlag, cameraData.backgroundColor, 1.0f, 0u);
                }
            }
            else
            {
#if UNITY_EDITOR
                if (cameraData.targetTexture != null && cameraData.targetTexture.useDynamicScale)
                {
                    cameraData.targetTexture.useDynamicScale = false;
                    Debug.LogError($"RenderTexture作为渲染目标时 禁止使用动态分辨率");
                }
#endif

                //渲染目标是RenderTexture或backBuffer 同时包含颜色和深度buffer
                RenderTargetIdentifier target = cameraData.targetTexture != null ?
                    cameraData.targetTexture : BuiltinRenderTextureType.CameraTarget;

                if (ins.activeColorTarget == target &&
                    ins.activeDepthTarget == target &&
                    cameraData.needFirstClearRT)
                {
                    cameraData.needFirstClearRT = false;

                    var clearFlag = GlobalLogic.GetCameraClearFlag(ref cameraData);
                    if (clearFlag != RTClearFlags.None)
                        cmd.ClearRenderTarget(clearFlag, cameraData.backgroundColor, 1.0f, 0u);
                }
                else if (ins.activeColorTarget != target ||
                     ins.activeDepthTarget != target)
                {
                    ins.activeColorTarget = target;
                    ins.activeDepthTarget = target;

                    var loadAction = RenderBufferLoadAction.Load;
                    var clearFlag = RTClearFlags.None;
                    if (cameraData.needFirstClearRT)
                    {
                        loadAction = RenderBufferLoadAction.DontCare;
                        clearFlag = GlobalLogic.GetCameraClearFlag(ref cameraData);
                        cameraData.needFirstClearRT = false;
                    }

                    target = new RenderTargetIdentifier(target, 0, CubemapFace.Unknown, -1);
                    cmd.SetRenderTarget(target, loadAction, RenderBufferStoreAction.Store); //颜色和深度的load和store操作一致
                    if (clearFlag != RTClearFlags.None)
                        cmd.ClearRenderTarget(clearFlag, cameraData.backgroundColor, 1.0f, 0u);
                }
            }
        }

        [System.Diagnostics.Conditional("UNITY_EDITOR")]
        public static void DrawGizmos(ScriptableRenderContext context, Camera camera, GizmoSubset gizmoSubset, ref RenderingData renderingData)
        {
#if UNITY_EDITOR
            if (!UnityEditor.Handles.ShouldRenderGizmos() || camera.sceneViewFilterMode == Camera.SceneViewFilterMode.ShowFiltered)
                return;

            var cmd = renderingData.commandBuffer;
            using (new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SekiaRenderer.DrawGizmos")))
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
        public static void DrawWireOverlay(ScriptableRenderContext context, Camera camera)
        {
#if UNITY_EDITOR
            context.DrawWireOverlay(camera);
#endif
        }

        public static Vector3[] GetFullScreenTriangleVertexPosition(float nearClipZ)
        {
            var r = new Vector3[3];
            for (int i = 0; i < 3; i++)
            {
                Vector2 uv = new Vector2((i << 1) & 2, i & 2);
                r[i] = new Vector3(uv.x * 2.0f - 1.0f, uv.y * 2.0f - 1.0f, nearClipZ);
            }
            return r;
        }

        public static Vector2[] GetFullScreenTriangleTexCoord()
        {
            var r = new Vector2[3];
            for (int i = 0; i < 3; i++)
                r[i] = new Vector2((i << 1) & 2, i & 2);
            return r;
        }

        public static RTClearFlags GetCameraClearFlag(ref CameraData cameraData)
        {
            var cameraClearFlags = cameraData.camera.clearFlags;
            if (cameraData.renderType == CameraRenderType.Overlay)
                return (cameraData.clearDepth) ? RTClearFlags.DepthStencil : RTClearFlags.None;

            if (cameraClearFlags == CameraClearFlags.Skybox && RenderSettings.skybox != null)
                return RTClearFlags.DepthStencil;

            return RTClearFlags.All;
        }

        public static bool CheckPostProcessForDepth(ref CameraData cameraData)
        {
            if (!cameraData.postProcessEnabled)
                return false;

            if (cameraData.antialiasing == AntialiasingMode.SubpixelMorphologicalAntiAliasing && cameraData.renderType == CameraRenderType.Base)
                return true;

            return CheckPostProcessForDepth();
        }

        public static bool CheckPostProcessForDepth()
        {
            var stack = VolumeManager.instance.stack;

            if (stack.GetComponent<DepthOfField>().IsActive())
                return true;

            if (stack.GetComponent<MotionBlur>().IsActive())
                return true;

            return false;
        }

        public static DrawingSettings CreateDrawingSettings(ShaderTagId shaderTagId, ref RenderingData renderingData, SortingCriteria sortingCriteria)
        {
            Camera camera = renderingData.cameraData.camera;
            SortingSettings sortingSettings = new SortingSettings(camera) { criteria = sortingCriteria };
            DrawingSettings settings = new DrawingSettings(shaderTagId, sortingSettings)
            {
                perObjectData = renderingData.perObjectData,
                mainLightIndex = renderingData.lightData.mainLightIndex,
                enableDynamicBatching = renderingData.supportsDynamicBatching,

                // Disable instancing for preview cameras. This is consistent with the built-in forward renderer. Also fixes case 1127324.
                enableInstancing = camera.cameraType == CameraType.Preview ? false : true,
            };
            return settings;
        }

        public static DrawingSettings CreateDrawingSettings(List<ShaderTagId> shaderTagIdList,
            ref RenderingData renderingData, SortingCriteria sortingCriteria)
        {
            if (shaderTagIdList == null || shaderTagIdList.Count == 0)
            {
                Debug.LogWarning("ShaderTagId list is invalid. DrawingSettings is created with default pipeline ShaderTagId");
                return CreateDrawingSettings(new ShaderTagId("UniversalPipeline"), ref renderingData, sortingCriteria);
            }

            DrawingSettings settings = CreateDrawingSettings(shaderTagIdList[0], ref renderingData, sortingCriteria);
            for (int i = 1; i < shaderTagIdList.Count; ++i)
                settings.SetShaderPassName(i, shaderTagIdList[i]);
            return settings;
        }
        //-----------------------------------------------------------------------------------------------------------------------------------------------------------------
    }
}
