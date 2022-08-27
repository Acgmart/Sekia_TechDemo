using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    public class CopyColorFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            FeatureSettings settings;
            int m_SampleOffsetShaderHandle;
            Material m_SamplingMaterial;
            Material m_CopyColorMaterial;
            Downsampling m_DownsamplingMethod;

            private RTHandle source;
            private RTHandle destination;

            public FeaturePass(FeatureSettings settings)
            {
                this.settings = settings;
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);

                m_SamplingMaterial = settings.samplingMaterial;
                m_CopyColorMaterial = settings.copyColorMaterial;
                m_SampleOffsetShaderHandle = Shader.PropertyToID("_SampleOffset");
                m_DownsamplingMethod = Downsampling.None;
                base.useNativeRenderPass = false;
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                this.source = GetRT(settings.srcColor);
                this.destination = GetRT(settings.dstColor);
                m_DownsamplingMethod = settings.downsampling;
                cmd.SetGlobalTexture(destination.name, destination.nameID);
            }

            /// <inheritdoc/>
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                if (m_SamplingMaterial == null || m_CopyColorMaterial == null)
                {
                    Debug.LogError("丢失材质 检查CopyColorFeature的输入材质");
                    return;
                }

                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(cmd, profilingSampler))
                {
                    ScriptableRenderer.SetRenderTarget(cmd, destination, ScriptableRendererFeature.k_CameraTarget, clearFlag,
                        clearColor);

                    bool useDrawProceduleBlit = false;
                    switch (m_DownsamplingMethod)
                    {
                        case Downsampling.None:
                            RenderingUtils.Blit(cmd, source, destination, m_CopyColorMaterial, 0, useDrawProceduleBlit);
                            break;
                        case Downsampling._2xBilinear:
                            RenderingUtils.Blit(cmd, source, destination, m_CopyColorMaterial, 0, useDrawProceduleBlit);
                            break;
                        case Downsampling._4xBox:
                            m_SamplingMaterial.SetFloat(m_SampleOffsetShaderHandle, 2);
                            RenderingUtils.Blit(cmd, source, destination, m_SamplingMaterial, 0, useDrawProceduleBlit);
                            break;
                        case Downsampling._4xBilinear:
                            RenderingUtils.Blit(cmd, source, destination, m_CopyColorMaterial, 0, useDrawProceduleBlit);
                            break;
                    }
                }

                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "CopyColorFeature";
            public Material copyColorMaterial = null;
            public Material samplingMaterial = null;
            public Downsampling downsampling;
            public RT_T0 srcColor = RT_T0.ColorMain;
            public RT_T0 dstColor = RT_T0.ColorCopy;
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Create()
        {
            if (string.IsNullOrEmpty(settings.profilerTag))
                settings.profilerTag = this.name;
            if (settings.copyColorMaterial == null)
                Debug.LogError("CopyColor材质不能为空");
            if (settings.samplingMaterial == null)
                Debug.LogError("Sampling材质不能为空");
            pass = new FeaturePass(settings);
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            RenderTextureDescriptor desc = renderingData.cameraData.cameraTargetDescriptor;
            desc.msaaSamples = 1;
            desc.depthBufferBits = 0;

            //获取RT描述
            if (settings.downsampling == Downsampling._2xBilinear)
            {
                desc.width /= 2;
                desc.height /= 2;
            }
            else if (settings.downsampling == Downsampling._4xBox || settings.downsampling == Downsampling._4xBilinear)
            {
                desc.width /= 4;
                desc.height /= 4;
            }
            FilterMode filterMode = settings.downsampling == Downsampling.None ? FilterMode.Point : FilterMode.Bilinear;

            //初始化RT
            RenderingUtils.ReAllocateIfNeeded(ref m_OpaqueColor, desc, filterMode, TextureWrapMode.Clamp, name: "_CameraOpaqueTexture");

            renderer.EnqueuePass(pass);
        }
    }
}
