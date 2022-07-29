using System;
using UnityEngine.Experimental.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using Sekia.Internal;

namespace Sekia
{
    public class MotionVectorFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            const string kPreviousViewProjectionMatrix = "_PrevViewProjMatrix";
            internal static readonly GraphicsFormat m_TargetFormat = GraphicsFormat.R16G16_SFloat;
            static readonly string[] s_ShaderTags = new string[] { "MotionVectors" };

            RTHandle m_Color;
            RTHandle m_Depth;
            readonly Material m_CameraMaterial;
            readonly Material m_ObjectMaterial;

            PreviousFrameData m_MotionData;
            ProfilingSampler m_ProfilingSampler = ProfilingSampler.Get(URPProfileId.MotionVectors);

            internal FeaturePass(FeatureSettings settings)
            {
                m_CameraMaterial = settings.cameraMaterial;
                m_ObjectMaterial = settings.objectMaterial;
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                SupportedRenderingFeatures.active.motionVectors = true; // hack for enabling UI
                var camera = renderingData.cameraData.camera;
                var colorDescriptor = renderingData.cameraData.cameraTargetDescriptor;
                colorDescriptor.graphicsFormat = m_TargetFormat;
                colorDescriptor.depthBufferBits = 0;
                RenderingUtils.ReAllocateIfNeeded(ref m_MotionVectorColor, colorDescriptor, FilterMode.Point, TextureWrapMode.Clamp, name: "_MotionVectorTexture");

                var depthDescriptor = renderingData.cameraData.cameraTargetDescriptor;
                depthDescriptor.graphicsFormat = GraphicsFormat.None;
                RenderingUtils.ReAllocateIfNeeded(ref m_MotionVectorDepth, depthDescriptor, FilterMode.Point, TextureWrapMode.Clamp, name: "_MotionVectorDepthTexture");

                m_MotionData = MotionVectorRendering.instance.GetMotionDataForCamera(camera);
                m_Color = m_MotionVectorColor;
                m_Depth = m_MotionVectorDepth;
            }

            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
            {
                cmd.SetGlobalTexture(m_Color.name, m_Color.nameID);
                cmd.SetGlobalTexture(m_Depth.name, m_Depth.nameID);
                ConfigureTarget(m_Color, m_Depth);
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                if (m_CameraMaterial == null || m_ObjectMaterial == null)
                    return;

                // Get data
                var camera = renderingData.cameraData.camera;

                // Never draw in Preview
                if (camera.cameraType == CameraType.Preview)
                    return;

                // Profiling command
                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(cmd, m_ProfilingSampler))
                {
                    ExecuteCommand(context, cmd);
                    var cameraData = renderingData.cameraData;
                    Shader.SetGlobalMatrix(kPreviousViewProjectionMatrix, m_MotionData.previousViewProjectionMatrix);

                    // These flags are still required in SRP or the engine won't compute previous model matrices...
                    // If the flag hasn't been set yet on this camera, motion vectors will skip a frame.
                    camera.depthTextureMode |= DepthTextureMode.MotionVectors | DepthTextureMode.Depth;

                    // TODO: add option to only draw either one?
                    DrawCameraMotionVectors(context, cmd, camera);
                    DrawObjectMotionVectors(context, ref renderingData, camera);
                }
                ExecuteCommand(context, cmd);
                CommandBufferPool.Release(cmd);
            }

            DrawingSettings GetDrawingSettings(ref RenderingData renderingData)
            {
                var camera = renderingData.cameraData.camera;
                var sortingSettings = new SortingSettings(camera) { criteria = SortingCriteria.CommonOpaque };
                var drawingSettings = new DrawingSettings(ShaderTagId.none, sortingSettings)
                {
                    perObjectData = PerObjectData.MotionVectors,
                    enableDynamicBatching = renderingData.supportsDynamicBatching,
                    enableInstancing = true,
                };

                for (int i = 0; i < s_ShaderTags.Length; ++i)
                {
                    drawingSettings.SetShaderPassName(i, new ShaderTagId(s_ShaderTags[i]));
                }

                // Material that will be used if shader tags cannot be found
                drawingSettings.fallbackMaterial = m_ObjectMaterial;

                return drawingSettings;
            }

            void DrawCameraMotionVectors(ScriptableRenderContext context, CommandBuffer cmd, Camera camera)
            {
                // Draw fullscreen quad
                cmd.DrawProcedural(Matrix4x4.identity, m_CameraMaterial, 0, MeshTopology.Triangles, 3, 1);
                ExecuteCommand(context, cmd);
            }

            void DrawObjectMotionVectors(ScriptableRenderContext context, ref RenderingData renderingData, Camera camera)
            {
                var drawingSettings = GetDrawingSettings(ref renderingData);
                var filteringSettings = new FilteringSettings(RenderQueueRange.opaque, camera.cullingMask);
                var renderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

                // Draw Renderers
                context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings, ref renderStateBlock);
            }

            void ExecuteCommand(ScriptableRenderContext context, CommandBuffer cmd)
            {
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "MotionVectorFeature";
            public Material cameraMaterial = null;
            public Material objectMaterial = null;
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Create()
        {
            if (string.IsNullOrEmpty(settings.profilerTag))
                settings.profilerTag = this.name;
            pass = new FeaturePass(settings);
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            renderer.EnqueuePass(pass);
        }
    }
}
