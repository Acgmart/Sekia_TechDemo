using UnityEngine;
using UnityEngine.Rendering;

namespace Sekia
{
    //[CreateAssetMenu(fileName = "ForwardTransparentSubPass", menuName = "Rendering/ForwardTransparentSubPass", order = 0)]
    public class ForwardTransparentSubPass : SekiaSubPass
    {
        public override void Init()
        {
            //m_RenderOpaqueForwardOnlyPass
        }

        public override void ExecuteSubPass(ScriptableRenderContext context, ref RenderingData renderingData)
        {

            ref CameraData cameraData = ref renderingData.cameraData;
            var cmd = renderingData.commandBuffer;
            var ins = GlobalData.Instance;
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.ForwardTransparent"));

            //propertyBlock.SetVector(GlobalData.ShaderIDs._BlitScaleBias, scaleBias);
            //propertyBlock.SetTexture(GlobalData.ShaderIDs._BlitTexture, source); 
            cmd.DrawProcedural(Matrix4x4.identity, ins.m_BlitMaterial, shaderPass: 0, MeshTopology.Triangles, 3, 1);

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }
    }
}
