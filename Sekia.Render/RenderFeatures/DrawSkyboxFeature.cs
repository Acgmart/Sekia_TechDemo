using UnityEngine.Rendering;
using UnityEngine;

namespace Sekia
{
    public class DrawSkyboxFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                //天空盒子必须对主RT进行渲染
                CameraData cameraData = renderingData.cameraData;
                Camera camera = cameraData.camera;
                context.DrawSkybox(camera);
            }
        }

        FeaturePass pass;

        public override void Create()
        {
            pass = new FeaturePass();
        }

        public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
        {
            Camera camera = renderingData.cameraData.camera;

            if (camera.clearFlags == CameraClearFlags.Skybox &&
                renderingData.cameraData.renderType == CameraRenderType.Base)
            {
                //场景的默认Skybox在RenderSettings
                //逐相机可覆盖场景默认设置
                if (RenderSettings.skybox != null ||
                    (camera.TryGetComponent(out Skybox cameraSkybox) && cameraSkybox.material != null))
                    renderer.EnqueuePass(pass);
            }
        }
    }
}
