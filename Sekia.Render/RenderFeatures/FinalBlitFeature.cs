using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering;
using UnityEngine.Experimental.Rendering;
using UnityEngine;

namespace Sekia
{
    public class FinalBlitFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            RTHandle m_CameraTargetHandle; //用于描述targetRenderTexture或backBuffer

            public FeaturePass(FeatureSettings settings)
            {
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);
                GlobalData.Instance.OnDispose += Dispose;
            }

            public void Dispose()
            {
                m_CameraTargetHandle?.Release();
            }

            /// <inheritdoc/>
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                if (GlobalData.Instance.m_BlitMaterial == null)
                {
                    Debug.LogError("GlobalData.Instance.m_BlitMaterial为空. FinalBlitFeature不会执行");
                    return;
                }

                //获取相机栈的targetTexture
                ref CameraData cameraData = ref renderingData.cameraData;

                //获取目标RTHandle
                {
                    RenderTargetIdentifier cameraTarget = (cameraData.targetTexture != null) ?
                                        new RenderTargetIdentifier(cameraData.targetTexture) : BuiltinRenderTextureType.CameraTarget;
                    if (m_CameraTargetHandle != cameraTarget)
                    {
                        m_CameraTargetHandle?.Release();
                        m_CameraTargetHandle = RTHandles.Alloc(cameraTarget);
                    }
                }

                var cmd = renderingData.commandBuffer;
                using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.FinalBlit)))
                {
                    CoreUtils.SetKeyword(cmd, ShaderKeywordStrings.LinearToSRGBConversion,
                        cameraData.requireSrgbConversion);

                    ExecutePass(ref renderingData, m_CameraTargetHandle);
                    cameraData.renderer.ConfigureCameraTarget(m_CameraTargetHandle, m_CameraTargetHandle);
                }
            }

            private void ExecutePass(ref RenderingData renderingData, RTHandle cameraTarget)
            {
                var cameraData = renderingData.cameraData;
                var cmd = renderingData.commandBuffer;
                RTHandle source = GlobalData.Instance.m_ColorBufferSystem.PeekBackBuffer();

                //多屏窗口在FinalBlit时需要Load旧内容
                var loadAction = RenderBufferLoadAction.DontCare;
                if (!cameraData.isSceneViewCamera && !cameraData.isDefaultViewport)
                    loadAction = RenderBufferLoadAction.Load;

                //类似cmd.Blit
                RenderingUtils.FinalBlit(cmd, ref cameraData, source, cameraTarget,
                    loadAction, RenderBufferStoreAction.Store, GlobalData.Instance.m_BlitMaterial,
                    source.rt?.filterMode == FilterMode.Bilinear ? 1 : 0); //颜色RT的模式默认是Bilinear的
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "FinalBlit";
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
