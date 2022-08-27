using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using Sekia.Internal;

namespace Sekia
{
    public class DepthNormalOnlyFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            FeatureSettings settings;
            List<ShaderTagId> shaderTagIds;
            private RTHandle depthHandle;
            private RTHandle normalHandle;
            private FilteringSettings m_FilteringSettings;
            private static readonly List<ShaderTagId> k_DepthNormals = new List<ShaderTagId> { new ShaderTagId("DepthNormalsOnly") };

            public FeaturePass(FeatureSettings settings)
            {
                this.settings = settings;
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);
                RenderQueueRange range = new RenderQueueRange(settings.RenderQueueStart, settings.RenderQueueEnd);
                m_FilteringSettings = new FilteringSettings(range, settings.layerMask);
                useNativeRenderPass = false;
            }

            public static GraphicsFormat GetGraphicsFormat()
            {

                if (RenderingUtils.SupportsGraphicsFormat(GraphicsFormat.R8G8B8A8_SNorm, FormatUsage.Render))
                    return GraphicsFormat.R8G8B8A8_SNorm; // Preferred format
                else if (RenderingUtils.SupportsGraphicsFormat(GraphicsFormat.R16G16B16A16_SFloat, FormatUsage.Render))
                    return GraphicsFormat.R16G16B16A16_SFloat; // fallback
                else
                    return GraphicsFormat.R32G32B32A32_SFloat; // fallback
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                //会强行关闭延迟渲染的NativeRenderPass

                int gbufferNormalIndex = m_DeferredLights.GBufferNormalSmoothnessIndex;
                ref var normalsTexture = ref m_DeferredLights.GbufferAttachments[gbufferNormalIndex];
                string normalsTextureName = normalsTexture.name;

                var normalDescriptor = renderingData.cameraData.cameraTargetDescriptor;
                normalDescriptor.depthBufferBits = 0;
                normalDescriptor.msaaSamples = 1;
                normalDescriptor.graphicsFormat = GetGraphicsFormat();

                RenderingUtils.ReAllocateIfNeeded(ref normalsTexture, normalDescriptor, FilterMode.Point, TextureWrapMode.Clamp, name: normalsTextureName);
                cmd.SetGlobalTexture(normalsTexture.name, normalsTexture.nameID);

                this.depthHandle = m_ActiveCameraDepthAttachment;
                this.normalHandle = normalsTexture;
                this.shaderTagIds = k_DepthNormals; ;

                if (renderingData.cameraData.renderer.useDepthPriming && (renderingData.cameraData.renderType == CameraRenderType.Base || renderingData.cameraData.clearDepth))
                    ConfigureTarget(normalHandle, renderingData.cameraData.renderer.cameraDepthTargetHandle);
                else
                    ConfigureTarget(normalHandle, depthHandle);

                ConfigureClear(ClearFlag.All, Color.black);
            }

            /// <inheritdoc/>
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                // NOTE: Do NOT mix ProfilingScope with named CommandBuffers i.e. CommandBufferPool.Get("name").
                // Currently there's an issue which results in mismatched markers.
                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.DepthNormalPrepass)))
                {
                    context.ExecuteCommandBuffer(cmd);
                    cmd.Clear();

                    var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
                    var drawSettings = CreateDrawingSettings(this.shaderTagIds, ref renderingData, sortFlags);
                    drawSettings.perObjectData = PerObjectData.None;

                    ref CameraData cameraData = ref renderingData.cameraData;
                    Camera camera = cameraData.camera;

                    context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref m_FilteringSettings);
                }
                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }

            /// <inheritdoc/>
            public override void OnCameraCleanup(CommandBuffer cmd)
            {
                if (cmd == null)
                {
                    throw new ArgumentNullException("cmd");
                }
                normalHandle = null;
                depthHandle = null;
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "DepthNormalOnlyFeature";
            [Range(0, 5000)]
            public int RenderQueueStart = 0;
            [Range(0, 5000)]
            public int RenderQueueEnd = 5000;
            public LayerMask layerMask = 0;
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
