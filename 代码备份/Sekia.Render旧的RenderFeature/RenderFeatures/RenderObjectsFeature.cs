using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering;
using UnityEngine.Experimental.Rendering;
using UnityEngine;

namespace Sekia
{
    public class RenderObjectsFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            FeatureSettings settings;
            FilteringSettings m_FilteringSettings;
            CustomCameraSettings m_CameraSettings;
            int specPropertyID;

            public Material overrideMaterial { get; set; }
            public int overrideMaterialPassIndex { get; set; }

            List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

            public void SetDetphState(bool writeEnabled, CompareFunction function = CompareFunction.Less)
            {
                m_RenderStateBlock.mask |= RenderStateMask.Depth;
                m_RenderStateBlock.depthState = new DepthState(writeEnabled, function);
            }

            public void SetStencilState(int reference, CompareFunction compareFunction, StencilOp passOp, StencilOp failOp, StencilOp zFailOp)
            {
                StencilState stencilState = StencilState.defaultValue;
                stencilState.enabled = true;
                stencilState.SetCompareFunction(compareFunction);
                stencilState.SetPassOperation(passOp);
                stencilState.SetFailOperation(failOp);
                stencilState.SetZFailOperation(zFailOp);

                m_RenderStateBlock.mask |= RenderStateMask.Stencil;
                m_RenderStateBlock.stencilReference = reference;
                m_RenderStateBlock.stencilState = stencilState;
            }

            RenderStateBlock m_RenderStateBlock;

            public FeaturePass(FeatureSettings settings, int layerMask, CustomCameraSettings cameraSettings)
            {
                this.settings = settings;
                if (settings.overrideSpecProperty)
                    specPropertyID = Shader.PropertyToID(settings.specPropertyName);
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);
                this.overrideMaterial = null;
                this.overrideMaterialPassIndex = 0;
                RenderQueueRange renderQueueRange = new RenderQueueRange(settings.filterSettings.RenderQueueStart, settings.filterSettings.RenderQueueEnd);
                m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);

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

                m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
                m_CameraSettings = cameraSettings;
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                SortingCriteria sortingCriteria = settings.filterSettings.opaqueSorting
                    ? renderingData.cameraData.defaultOpaqueSortFlags
                    : SortingCriteria.CommonTransparent;

                DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
                drawingSettings.overrideMaterial = overrideMaterial;
                drawingSettings.overrideMaterialPassIndex = overrideMaterialPassIndex;

                ref CameraData cameraData = ref renderingData.cameraData;
                Camera camera = cameraData.camera;

                // In case of camera stacking we need to take the viewport rect from base camera
                Rect pixelRect = renderingData.cameraData.pixelRect;
                float cameraAspect = (float)pixelRect.width / (float)pixelRect.height;

                // NOTE: Do NOT mix ProfilingScope with named CommandBuffers i.e. CommandBufferPool.Get("name").
                // Currently there's an issue which results in mismatched markers.
                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(cmd, profilingSampler))
                {
                    if (m_CameraSettings.overrideCamera)
                    {
                        Matrix4x4 projectionMatrix = Matrix4x4.Perspective(m_CameraSettings.cameraFieldOfView, cameraAspect,
                                camera.nearClipPlane, camera.farClipPlane);
                        projectionMatrix = GL.GetGPUProjectionMatrix(projectionMatrix, cameraData.IsCameraProjectionMatrixFlipped());

                        Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
                        Vector4 cameraTranslation = viewMatrix.GetColumn(3);
                        viewMatrix.SetColumn(3, cameraTranslation + m_CameraSettings.offset);

                        RenderingUtils.SetViewAndProjectionMatrices(cmd, viewMatrix, projectionMatrix, false);
                    }

                    {
                        //声明临时性的全局变量
                        if (settings.overrideSpecProperty)
                            cmd.SetGlobalInt(specPropertyID, settings.specPropertyValueStart);

                        // Ensure we flush our command-buffer before we render...
                        context.ExecuteCommandBuffer(cmd);
                        cmd.Clear();

#if UNITY_EDITOR
                        // When rendering the preview camera, we want the layer mask to be forced to Everything
                        if (renderingData.cameraData.isPreviewCamera)
                        {
                            m_FilteringSettings.layerMask = -1;
                        }
#endif

                        // Render the objects...
                        context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings, ref m_RenderStateBlock);


                        //取消临时性的全局变量
                        if (settings.overrideSpecProperty)
                            cmd.SetGlobalInt(specPropertyID, settings.specPropertyValueEnd);
                    }

                    if (m_CameraSettings.overrideCamera && m_CameraSettings.restoreCamera)
                    {
                        RenderingUtils.SetViewAndProjectionMatrices(cmd, cameraData.GetViewMatrix(), cameraData.GetGPUProjectionMatrix(), false);
                    }
                }
                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "RenderObjectsFeature";

            [Space]
            public FilterSettings filterSettings = new FilterSettings();
            public Material overrideMaterial = null;
            public int overrideMaterialPassIndex = 0;

            [Space]
            public bool overrideSpecProperty = false;
            public string specPropertyName = "";
            public int specPropertyValueStart = 1;
            public int specPropertyValueEnd = 0;

            [Space]
            public bool overrideDepthState = false;
            public CompareFunction depthCompareFunction = CompareFunction.LessEqual;
            public bool enableWrite = true;

            [Space]
            public StencilStateData stencilSettings = new StencilStateData();

            [Space]
            public CustomCameraSettings cameraSettings = new CustomCameraSettings();
        }

        [System.Serializable]
        public class FilterSettings
        {
            [Range(0, 5000)]
            public int RenderQueueStart = 0;
            [Range(0, 5000)]
            public int RenderQueueEnd = 5000;
            public bool opaqueSorting = true;
            public LayerMask LayerMask = 0;
            public string[] shaderTags;
        }

        [System.Serializable]
        public class CustomCameraSettings
        {
            public bool overrideCamera = false;
            public bool restoreCamera = true;
            public Vector4 offset;
            public float cameraFieldOfView = 60.0f;
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Create()
        {
            if (string.IsNullOrEmpty(settings.profilerTag))
                settings.profilerTag = this.name;
            FilterSettings filter = settings.filterSettings;

            pass = new FeaturePass(settings, filter.LayerMask, settings.cameraSettings);

            pass.overrideMaterial = settings.overrideMaterial;
            pass.overrideMaterialPassIndex = settings.overrideMaterialPassIndex;

            if (settings.overrideDepthState)
                pass.SetDetphState(settings.enableWrite, settings.depthCompareFunction);

            if (settings.stencilSettings.overrideStencilState)
                pass.SetStencilState(settings.stencilSettings.stencilReference,
                    settings.stencilSettings.stencilCompareFunction, settings.stencilSettings.passOperation,
                    settings.stencilSettings.failOperation, settings.stencilSettings.zFailOperation);
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            renderer.EnqueuePass(pass);
        }

        internal override bool SupportsNativeRenderPass()
        {
            return true;
        }
    }
}
