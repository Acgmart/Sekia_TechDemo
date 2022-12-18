using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using Unity.Collections;

namespace Sekia
{
    //[CreateAssetMenu(fileName = "WriteGBufferSubPass", menuName = "Rendering/WriteGBufferSubPass", order = 0)]
    public class WriteGBufferSubPass : SekiaSubPass
    {
        [System.Serializable]
        public class FilterSettings
        {
            [Range(0, 5000)]
            public int RenderQueueStart = 0;
            [Range(0, 5000)]
            public int RenderQueueEnd = 5000;
            public LayerMask layerMask = -1;
            public string[] shaderTags;
        }

        [System.Serializable]
        public class SubPassSettings
        {
            public string profilerTag = "RenderObjectsFeature";

            [Space]
            public FilterSettings filterSettings = new FilterSettings();

            [Space]
            public StencilStateData stencilSettings = new StencilStateData();
        }

        public SubPassSettings settings = new SubPassSettings();

        static ShaderTagId[] s_ShaderTagValues;
        static RenderStateBlock[] s_RenderStateBlocks;
        RenderStateBlock m_RenderStateBlock;

        internal static RenderStateBlock OverwriteStencil(RenderStateBlock block, int stencilWriteMask, int stencilRef)
        {
            if (!block.stencilState.enabled)
            {
                block.stencilState = new StencilState(
                    true,
                    0, (byte)stencilWriteMask,
                    CompareFunction.Always, StencilOp.Replace, StencilOp.Keep, StencilOp.Keep,
                    CompareFunction.Always, StencilOp.Replace, StencilOp.Keep, StencilOp.Keep
                );
            }
            else
            {
                StencilState s = block.stencilState;
                CompareFunction funcFront = s.compareFunctionFront != CompareFunction.Disabled ? s.compareFunctionFront : CompareFunction.Always;
                CompareFunction funcBack = s.compareFunctionBack != CompareFunction.Disabled ? s.compareFunctionBack : CompareFunction.Always;
                StencilOp passFront = s.passOperationFront;
                StencilOp failFront = s.failOperationFront;
                StencilOp zfailFront = s.zFailOperationFront;
                StencilOp passBack = s.passOperationBack;
                StencilOp failBack = s.failOperationBack;
                StencilOp zfailBack = s.zFailOperationBack;

                block.stencilState = new StencilState(
                    true,
                    (byte)(s.readMask & 0x0F), (byte)(s.writeMask | stencilWriteMask),
                    funcFront, passFront, failFront, zfailFront,
                    funcBack, passBack, failBack, zfailBack
                );
            }

            block.mask |= RenderStateMask.Stencil;
            block.stencilReference = (block.stencilReference & (int)StencilUsage.UserMask) | stencilRef;

            return block;
        }

        public override void Init()
        {
            StencilStateData stencilData = settings.stencilSettings;
            var defaultStencilState = StencilState.defaultValue;
            defaultStencilState.enabled = stencilData.overrideStencilState;
            defaultStencilState.SetCompareFunction(stencilData.stencilCompareFunction);
            defaultStencilState.SetPassOperation(stencilData.passOperation);
            defaultStencilState.SetFailOperation(stencilData.failOperation);
            defaultStencilState.SetZFailOperation(stencilData.zFailOperation);

            if (s_ShaderTagValues == null)
            {
                s_ShaderTagValues = new ShaderTagId[2];
                s_ShaderTagValues[0] = GlobalData.ShaderTagIds.s_ShaderTagLit;
                s_ShaderTagValues[1] = new ShaderTagId(); // Special catch all case for materials where UniversalMaterialType is not defined or the tag value doesn't match anything we know.
            }

            m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
            m_RenderStateBlock.stencilState = defaultStencilState;
            m_RenderStateBlock.stencilReference = stencilData.stencilReference;
            m_RenderStateBlock.mask = RenderStateMask.Stencil;

            if (s_RenderStateBlocks == null)
            {
                s_RenderStateBlocks = new RenderStateBlock[2];
                s_RenderStateBlocks[0] = OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialLit, (int)StencilUsage.MaterialLit);
                s_RenderStateBlocks[1] = s_RenderStateBlocks[0];
            }
        }

        public override void ExecuteSubPass(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            ref CameraData cameraData = ref renderingData.cameraData;
            var cmd = renderingData.commandBuffer;
            var ins = GlobalData.Instance;
            using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("SubPass.WriteGBuffer"));

            if (cameraData.needSetViewPort)
                GlobalLogic.ResetCameraMatrices(cmd, ref cameraData, cameraData.viewMatrix, cameraData.projectionMatrix);

            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();

            RenderQueueRange renderQueueRange = new RenderQueueRange(settings.filterSettings.RenderQueueStart, settings.filterSettings.RenderQueueEnd);
            FilteringSettings filteringSettings = new FilteringSettings(renderQueueRange, settings.filterSettings.layerMask);

            ShaderTagId lightModeTag = GlobalData.ShaderTagIds.UniversalGBuffer;
            SortingCriteria sortingCriteria = renderingData.cameraData.defaultOpaqueSortFlags;
            DrawingSettings drawingSettings = GlobalLogic.CreateDrawingSettings(lightModeTag, ref renderingData, sortingCriteria);

            NativeArray<ShaderTagId> tagValues = new NativeArray<ShaderTagId>(s_ShaderTagValues, Allocator.Temp);
            NativeArray<RenderStateBlock> stateBlocks = new NativeArray<RenderStateBlock>(s_RenderStateBlocks, Allocator.Temp);

            context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings,
                GlobalData.ShaderTagIds.s_ShaderTagUniversalMaterialType, false, tagValues, stateBlocks);

            tagValues.Dispose();
            stateBlocks.Dispose();

            profScope.Dispose();
            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
        }
    }
}
