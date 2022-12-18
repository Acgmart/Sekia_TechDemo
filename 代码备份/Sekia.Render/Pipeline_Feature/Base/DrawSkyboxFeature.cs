using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Sekia
{
    public class DrawSkyboxFeature : SekiaRendererFeature
    {
        public class FeaturePass : SekiaRendererPass
        {
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                Camera camera = renderingData.cameraData.camera;
                context.DrawSkybox(camera);
            }

            public override void OnCameraCleanup(CommandBuffer cmd)
            {
            }
        }

        FeaturePass pass;

        public override void Init()
        {
            pass = new FeaturePass();
        }

        public override void AddRenderPasses(SekiaRenderer renderer, ref RenderingData renderingData)
        {
            //仅在Forward渲染路径执行
            bool useRenderPass = renderer.useRenderPass;
#if UNITY_EDITOR
            useRenderPass &= renderingData.cameraData.isRenderPassSupportedCamera;
#endif
            if (!useRenderPass)
            {
                Camera camera = renderingData.cameraData.camera;

                if (camera.clearFlags == CameraClearFlags.Skybox &&
                    renderingData.cameraData.renderType == CameraRenderType.Base)
                {
                    //场景的默认Skybox在RenderSettings
                    //逐相机可覆盖场景默认设置
                    if (RenderSettings.skybox != null ||
                        (camera.TryGetComponent(out Skybox cameraSkybox) && cameraSkybox.material != null))
                        renderer.activeRenderPassQueue.Add(pass);
                }
            }
        }
    }
}
