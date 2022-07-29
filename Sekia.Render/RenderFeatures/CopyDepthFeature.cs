using System;
using UnityEngine.Experimental.Rendering;
using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    public class CopyDepthFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            public FeatureSettings settings;
            private RTHandle source;
            private RTHandle destination;
            Material m_CopyDepthMaterial;
            public bool CopyToDepthBuffer;

            public FeaturePass(FeatureSettings settings)
            {
                this.settings = settings;
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);
                this.CopyToDepthBuffer = settings.copyToDepthBuffer;
                m_CopyDepthMaterial = settings.copyDepthMaterial;
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                if (settings.dstDepth == RT_T0.DepthCopy)
                {
                    var depthDescriptor = renderingData.cameraData.cameraTargetDescriptor;
                    depthDescriptor.graphicsFormat = GraphicsFormat.R32_SFloat;
                    depthDescriptor.depthStencilFormat = GraphicsFormat.None;
                    depthDescriptor.depthBufferBits = 0;
                    depthDescriptor.msaaSamples = 1;// Depth-Only pass don't use MSAA
                    RenderingUtils.ReAllocateIfNeeded(ref m_DepthTexture, depthDescriptor, FilterMode.Point, wrapMode: TextureWrapMode.Clamp, name: "_CameraDepthTexture");
                    cmd.SetGlobalTexture(m_DepthTexture.name, m_DepthTexture.nameID);
                }

                source = GetRT(settings.srcDepth);
                destination = GetRT(settings.dstDepth);

                var descriptor = renderingData.cameraData.cameraTargetDescriptor;
                var isDepth = (destination.rt && destination.rt.graphicsFormat == GraphicsFormat.None);
                descriptor.graphicsFormat = isDepth ? GraphicsFormat.D32_SFloat_S8_UInt : GraphicsFormat.R32_SFloat;
                descriptor.msaaSamples = 1;
                if (Define._IsEditor)
                    ConfigureTarget(destination, destination, GraphicsFormat.R32_SFloat, descriptor.width, descriptor.height, descriptor.msaaSamples, false);
                else
                    ConfigureTarget(destination, descriptor.graphicsFormat, descriptor.width, descriptor.height, descriptor.msaaSamples, isDepth);
                ConfigureClear(ClearFlag.None, Color.black);
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                if (m_CopyDepthMaterial == null)
                {
                    Debug.LogErrorFormat("Missing {0}. {1} render pass will not execute. Check for missing reference in the renderer resources.", m_CopyDepthMaterial, GetType().Name);
                    return;
                }

                CommandBuffer cmd = CommandBufferPool.Get();
                using (new ProfilingScope(cmd, profilingSampler))
                {
                    CameraData cameraData = renderingData.cameraData;

                    //_CameraTarget的rt为null
                    if (CopyToDepthBuffer || destination.rt.graphicsFormat == GraphicsFormat.None)
                        cmd.EnableShaderKeyword("_OUTPUT_DEPTH");
                    else
                        cmd.DisableShaderKeyword("_OUTPUT_DEPTH");

                    cmd.SetGlobalTexture("_CameraDepthAttachment", source.nameID);

                    {
                        // Blit has logic to flip projection matrix when rendering to render texture.
                        // Currently the y-flip is handled in CopyDepthPass.hlsl by checking _ProjectionParams.x
                        // If you replace this Blit with a Draw* that sets projection matrix double check
                        // to also update shader.
                        // scaleBias.x = flipSign
                        // scaleBias.y = scale
                        // scaleBias.z = bias
                        // scaleBias.w = unused
                        // In game view final target acts as back buffer were target is not flipped
                        bool isGameViewFinalTarget = (cameraData.cameraType == CameraType.Game && destination.nameID == k_CameraTarget.nameID);
                        bool yflip = (cameraData.IsCameraProjectionMatrixFlipped()) && !isGameViewFinalTarget;
                        float flipSign = yflip ? -1.0f : 1.0f;
                        Vector4 scaleBiasRt = (flipSign < 0.0f)
                            ? new Vector4(flipSign, 1.0f, -1.0f, 1.0f)
                            : new Vector4(flipSign, 0.0f, 1.0f, 1.0f);
                        cmd.SetGlobalVector(ShaderPropertyId.scaleBiasRt, scaleBiasRt);

                        cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, m_CopyDepthMaterial);
                    }
                }

                context.ExecuteCommandBuffer(cmd);
                CommandBufferPool.Release(cmd);
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "CopyDepthFeature";
            public bool copyToDepthBuffer = false;
            public Material copyDepthMaterial = null;
            public RT_T0 srcDepth = RT_T0.DepthMain;
            public RT_T0 dstDepth = RT_T0.DepthCopy;
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Create()
        {
            if (string.IsNullOrEmpty(settings.profilerTag))
                settings.profilerTag = this.name;
            if (settings.copyDepthMaterial == null)
                Debug.LogError("CopyDepth材质不能为空");
            pass = new FeaturePass(settings);
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            renderer.EnqueuePass(pass);
        }
    }
}
