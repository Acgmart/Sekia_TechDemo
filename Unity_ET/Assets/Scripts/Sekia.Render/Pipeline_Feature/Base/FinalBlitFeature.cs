using UnityEngine.Rendering;
using UnityEngine;

namespace Sekia
{
    public class FinalBlitFeature : SekiaRendererFeature
    {
        public class FeaturePass : SekiaRendererPass
        {
            public MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                var ins = GlobalData.Instance;
                if (ins.m_BlitMaterial == null)
                {
                    Debug.LogError("GlobalData.Instance.m_BlitMaterial为空. FinalBlitFeature不会执行");
                    return;
                }

                ref CameraData cameraData = ref renderingData.cameraData;
                var cmd = renderingData.commandBuffer;
                using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("RenderPass.FinalBlit"));

#if UNITY_EDITOR
                if (cameraData.targetTexture != null && cameraData.targetTexture.useDynamicScale)
                {
                    cameraData.targetTexture.useDynamicScale = false;
                    Debug.LogError($"RenderTexture作为渲染目标时 禁止使用动态分辨率");
                }
#endif 

                var source = cameraData.mainColorAttachment;
                RenderTargetIdentifier target = (cameraData.targetTexture != null) ?
                    cameraData.targetTexture : BuiltinRenderTextureType.CameraTarget;
                ins.activeColorTarget = target;
                ins.activeDepthTarget = target;

                //参考：
                //We use -1 as a default value because when doing SPI for XR, it will bind the full texture array by default (and has no effect on 2D textures)
                //Unfortunately, for cubemaps, passing -1 does not work for faces other than the first one, so we fall back to 0 in this case.

                //一帧中第一次设置backBuffer为RenderTarget时 无需load
                //第二次开始需要load
                target = new RenderTargetIdentifier(target, 0, CubemapFace.Unknown, -1); //设置depthSlice为-1
                cmd.SetRenderTarget(target, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
                cmd.SetViewport(cameraData.pixelRect);

                bool requireSrgbConversion = cameraData.targetTexture == null && Display.main.requiresSrgbBlitToBackbuffer;
                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._LINEAR_TO_SRGB_CONVERSION, requireSrgbConversion);
                propertyBlock.SetTexture(GlobalData.ShaderPropertyIDs._BlitTexture, source); //避免使用nameID设置为Global属性

                //Point采样 中间RT与backBuffer一样大 不支持动态分辨率
                if (ins.graphicsShaderLevel < 30)
                    cmd.DrawMesh(ins.triangleMesh, Matrix4x4.identity, ins.m_BlitMaterial, 0, shaderPass: 0, propertyBlock);
                else
                    cmd.DrawProcedural(Matrix4x4.identity, ins.m_BlitMaterial, shaderPass: 0, MeshTopology.Triangles, 3, 1, propertyBlock);

                profScope.Dispose();
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
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
            if (renderingData.cameraData.useIntermediateRT)
                renderer.activeRenderPassQueue.Add(pass);
        }
    }
}
