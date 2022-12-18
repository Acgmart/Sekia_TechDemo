using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering;
using UnityEngine.Experimental.Rendering;
using UnityEngine;

namespace Sekia
{
    public class RenderObjectsFeature : SekiaRendererFeature
    {
        public class FeaturePass : SekiaRendererPass
        {
            static ForwardData forwardData;
            FeatureSettings settings;
            List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

            public FeaturePass(FeatureSettings settings)
            {
                if (forwardData == null)
                    forwardData = new ForwardData();

                this.settings = settings;

                if (settings.filterSettings.shaderTags != null && settings.filterSettings.shaderTags.Length > 0)
                {
                    foreach (var passName in settings.filterSettings.shaderTags)
                        m_ShaderTagIdList.Add(new ShaderTagId(passName));
                }
                else
                {
                    m_ShaderTagIdList.Add(new ShaderTagId("SRPDefaultUnlit"));
                    m_ShaderTagIdList.Add(new ShaderTagId("UniversalForward"));
                    m_ShaderTagIdList.Add(new ShaderTagId("UniversalForwardOnly"));
                }
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                RenderQueueRange renderQueueRange = new RenderQueueRange(settings.filterSettings.RenderQueueStart, settings.filterSettings.RenderQueueEnd);
                FilteringSettings filteringSettings = new FilteringSettings(renderQueueRange, settings.filterSettings.layerMask);
                RenderStateBlock renderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

                SortingCriteria sortingCriteria = settings.filterSettings.opaqueSorting
                    ? renderingData.cameraData.defaultOpaqueSortFlags
                    : SortingCriteria.CommonTransparent;

                DrawingSettings drawingSettings = GlobalLogic.CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);

                //Overrides
                {
                    if (settings.useOverrideMaterial)
                    {
                        drawingSettings.overrideMaterial = settings.overrideMaterial;
                        drawingSettings.overrideMaterialPassIndex = settings.overrideMaterialPassIndex;
                    }
#if UNITY_2022_2_OR_NEWER
                    if (settings.useOverrideShader)
                    {
                        drawingSettings.overrideShader = settings.overrideShader;
                        drawingSettings.overrideShaderPassIndex = settings.overrideShaderPassIndex;
                    }
#endif
                    if (settings.overrideDepthState)
                    {
                        renderStateBlock.mask |= RenderStateMask.Depth;
                        renderStateBlock.depthState = new DepthState(settings.enableDepthWrite, settings.depthCompareFunction);
                    }
                    if (settings.stencilSettings.overrideStencilState)
                    {
                        StencilState stencilState = StencilState.defaultValue;
                        stencilState.enabled = true;
                        stencilState.SetCompareFunction(settings.stencilSettings.stencilCompareFunction);
                        stencilState.SetPassOperation(settings.stencilSettings.passOperation);
                        stencilState.SetFailOperation(settings.stencilSettings.failOperation);
                        stencilState.SetZFailOperation(settings.stencilSettings.zFailOperation);

                        renderStateBlock.mask |= RenderStateMask.Stencil;
                        renderStateBlock.stencilReference = settings.stencilSettings.stencilReference;
                        renderStateBlock.stencilState = stencilState;
                    }
                }

                ref CameraData cameraData = ref renderingData.cameraData;
                Camera camera = cameraData.camera;
                SekiaRenderer renderer = cameraData.renderer;
                var ins = GlobalData.Instance;

                //光照设置
                if (cameraData.cameraNeedSetupForwardLight)
                {
                    cameraData.cameraNeedSetupForwardLight = false;
                    using (new ProfilingScope(null, GlobalData.Profiling.TryGetOrAddSampler("SekiaRenderer.SetupLights")))
                        forwardData.Setup(context, ref renderingData);
                }

                var cmd = renderingData.commandBuffer;
                using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler(settings.profilerTag));

                if (settings.cameraSettings.overrideCamera)
                {
                    Rect pixelRect = renderingData.cameraData.pixelRect;
                    float cameraAspect = (float)pixelRect.width / (float)pixelRect.height;
                    Matrix4x4 projectionMatrix = Matrix4x4.Perspective(settings.cameraSettings.cameraFieldOfView, cameraAspect,
                        camera.nearClipPlane, camera.farClipPlane);

                    Matrix4x4 viewMatrix = cameraData.viewMatrix;
                    Vector4 cameraPosition = viewMatrix.GetColumn(3);
                    Vector4 positionOffset = settings.cameraSettings.positionOffset;
                    viewMatrix.SetColumn(3, cameraPosition + positionOffset);

                    GlobalLogic.ResetCameraMatrices(cmd, ref cameraData, viewMatrix, projectionMatrix);
                    cameraData.needSetViewPort = true;
                }
                else if (cameraData.needSetViewPort)
                    GlobalLogic.ResetCameraMatrices(cmd, ref cameraData, cameraData.viewMatrix, cameraData.projectionMatrix);

                GlobalLogic.ResetDefaultRenderTarget(cmd, renderer, ref cameraData, ins);

                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                // Render the objects...
                context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings, ref renderStateBlock);

                profScope.Dispose();
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            public override void OnCameraCleanup(CommandBuffer cmd)
            {
            }
        }

        [System.Serializable]
        public class FilterSettings
        {
            [Range(0, 5000)]
            public int RenderQueueStart = 0;
            [Range(0, 5000)]
            public int RenderQueueEnd = 5000;
            public bool opaqueSorting = true;
            public LayerMask layerMask = -1;
            public string[] shaderTags;
        }

        [System.Serializable]
        public class CustomCameraSettings
        {
            public bool overrideCamera = false;
            public Vector3 positionOffset;
            public float cameraFieldOfView = 60.0f;
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "RenderObjectsFeature";

            [Space]
            public FilterSettings filterSettings = new FilterSettings();

            [Space]
            public bool useOverrideMaterial = false;
            public Material overrideMaterial = null;
            public int overrideMaterialPassIndex = 0;
            public bool useOverrideShader = false;
            public Shader overrideShader = null;
            public int overrideShaderPassIndex = 0;

            [Space]
            public bool overrideDepthState = false;
            public CompareFunction depthCompareFunction = CompareFunction.LessEqual;
            public bool enableDepthWrite = true;

            [Space]
            public StencilStateData stencilSettings = new StencilStateData();

            [Space]
            public CustomCameraSettings cameraSettings = new CustomCameraSettings();
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Init()
        {
            if (string.IsNullOrEmpty(settings.profilerTag))
                settings.profilerTag = this.name;
            pass = new FeaturePass(settings);
        }

        public override void AddRenderPasses(SekiaRenderer renderer, ref RenderingData renderingData)
        {
            //仅在Forward渲染路径执行
            bool useRenderPass = renderer.useRenderPass;
#if UNITY_EDITOR
            useRenderPass &= renderingData.cameraData.isRenderPassSupportedCamera;
#endif
            if (!useRenderPass)
                renderer.activeRenderPassQueue.Add(pass);
        }
    }
}
