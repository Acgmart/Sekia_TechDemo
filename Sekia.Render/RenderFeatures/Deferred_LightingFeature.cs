using UnityEngine.Experimental.GlobalIllumination;
using UnityEngine.Profiling;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    public class Deferred_LightingFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            FeatureSettings settings;
            public bool useRenderPassEnabled;
            public FeaturePass(FeatureSettings settings)
            {
                this.settings = settings;
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                if (useRenderPassEnabled && ScriptableRendererFeature.m_DeferredLights.UseRenderPass)
                {
                    this.Configure(null, renderingData.cameraData.cameraTargetDescriptor);
                }
            }

            // ScriptableRenderPass
            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescripor)
            {
                var lightingAttachment = m_DeferredLights.GbufferAttachments[m_DeferredLights.GBufferLightingIndex];
                var depthAttachment = m_DeferredLights.DepthAttachmentHandle;
                if (m_DeferredLights.UseRenderPass)
                    ConfigureInputAttachments(m_DeferredLights.DeferredInputAttachments, m_DeferredLights.DeferredInputIsTransient);

                // TODO: change to m_DeferredLights.GetGBufferFormat(m_DeferredLights.GBufferLightingIndex) when it's not GraphicsFormat.None
                // TODO: Cannot currently bind depth texture as read-only!
                ConfigureTarget(lightingAttachment, depthAttachment, cameraTextureDescripor.graphicsFormat);
            }

            // ScriptableRenderPass
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                m_DeferredLights.ExecuteDeferredPass(context, ref renderingData);
            }

            // ScriptableRenderPass
            public override void OnCameraCleanup(CommandBuffer cmd)
            {
                m_DeferredLights.OnCameraCleanup(cmd);
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "Deferred_LightingFeature";
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
            pass.useRenderPassEnabled = renderer.useRenderPassEnabled;
            renderer.EnqueuePass(pass);
        }
    }
}
