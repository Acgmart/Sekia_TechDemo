using UnityEngine.Experimental.GlobalIllumination;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Profiling;
using Unity.Collections;
using UnityEngine.Rendering;
using UnityEngine;
using Sekia.Internal;

namespace Sekia
{
    public class Deferred_GbufferFeature : ScriptableRendererFeature
    {
        public class FeaturePass : ScriptableRenderPass
        {
            public bool useRenderPassEnabled;
            FeatureSettings settings;
            static readonly int s_CameraNormalsTextureID = Shader.PropertyToID("_CameraNormalsTexture");
            static ShaderTagId s_ShaderTagLit = new ShaderTagId("Lit");
            static ShaderTagId s_ShaderTagSimpleLit = new ShaderTagId("SimpleLit");
            static ShaderTagId s_ShaderTagUnlit = new ShaderTagId("Unlit");
            static ShaderTagId s_ShaderTagUniversalGBuffer = new ShaderTagId("UniversalGBuffer");
            static ShaderTagId s_ShaderTagUniversalMaterialType = new ShaderTagId("UniversalMaterialType");

            ProfilingSampler m_ProfilingSampler = new ProfilingSampler("Render GBuffer");

            ShaderTagId[] m_ShaderTagValues;
            RenderStateBlock[] m_RenderStateBlocks;

            FilteringSettings m_FilteringSettings;
            RenderStateBlock m_RenderStateBlock;

            public FeaturePass(FeatureSettings settings)
            {
                this.settings = settings;
                base.profilingSampler = new ProfilingSampler(settings.profilerTag);

                RenderQueueRange renderQueueRange = new RenderQueueRange(settings.RenderQueueStart, settings.RenderQueueEnd);
                m_FilteringSettings = new FilteringSettings(renderQueueRange, settings.layerMask);
                m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

                StencilStateData stencilData = settings.stencilStateData;
                StencilState m_DefaultStencilState = StencilState.defaultValue;
                m_DefaultStencilState.enabled = stencilData.overrideStencilState;
                m_DefaultStencilState.SetCompareFunction(stencilData.stencilCompareFunction);
                m_DefaultStencilState.SetPassOperation(stencilData.passOperation);
                m_DefaultStencilState.SetFailOperation(stencilData.failOperation);
                m_DefaultStencilState.SetZFailOperation(stencilData.zFailOperation);

                m_RenderStateBlock.stencilState = m_DefaultStencilState;
                m_RenderStateBlock.stencilReference = stencilData.stencilReference;
                m_RenderStateBlock.mask = RenderStateMask.Stencil;

                m_ShaderTagValues = new ShaderTagId[4];
                m_ShaderTagValues[0] = s_ShaderTagLit;
                m_ShaderTagValues[1] = s_ShaderTagSimpleLit;
                m_ShaderTagValues[2] = s_ShaderTagUnlit;
                m_ShaderTagValues[3] = new ShaderTagId(); // Special catch all case for materials where UniversalMaterialType is not defined or the tag value doesn't match anything we know.

                m_RenderStateBlocks = new RenderStateBlock[4];
                m_RenderStateBlocks[0] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialLit);
                m_RenderStateBlocks[1] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialSimpleLit);
                m_RenderStateBlocks[2] = DeferredLights.OverwriteStencil(m_RenderStateBlock, (int)StencilUsage.MaterialMask, (int)StencilUsage.MaterialUnlit);
                m_RenderStateBlocks[3] = m_RenderStateBlocks[0];

                onDispose += Dispose;
            }

            public void Dispose()
            {
                if (m_DeferredLights.GbufferAttachments != null)
                {
                    foreach (var attachment in m_DeferredLights.GbufferAttachments)
                        attachment?.Release();
                }
            }

            public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
            {
                if (ScriptableRendererFeature.m_DeferredLights.UseRenderPass &&
                   (settings.hasNormalPrepass || !useRenderPassEnabled))
                    ScriptableRendererFeature.m_DeferredLights.DisableFramebufferFetchInput();

                ScriptableRendererFeature.m_DeferredLights.Setup(
                applyAdditionalShadow ? m_AdditionalLightsShadowCasterPass : null,
                settings.hasNormalPrepass,
                ScriptableRendererFeature.m_DepthTexture,
                ScriptableRendererFeature.m_ActiveCameraDepthAttachment,
                ScriptableRendererFeature.m_ActiveCameraColorAttachment);

                if (useRenderPassEnabled && ScriptableRendererFeature.m_DeferredLights.UseRenderPass)
                {
                    this.Configure(null, renderingData.cameraData.cameraTargetDescriptor);
                }

            }

            public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
            {
                RTHandle[] gbufferAttachments = m_DeferredLights.GbufferAttachments;

                if (cmd != null)
                {
                    var allocateGbufferDepth = true;
                    if (m_DeferredLights.UseRenderPass && (m_DeferredLights.DepthCopyTexture != null && m_DeferredLights.DepthCopyTexture.rt != null))
                    {
                        m_DeferredLights.GbufferAttachments[m_DeferredLights.GbufferDepthIndex] = m_DeferredLights.DepthCopyTexture;
                        m_DeferredLights.GbufferAttachmentIdentifiers[m_DeferredLights.GbufferDepthIndex] = m_DeferredLights.DepthCopyTexture.nameID;
                        allocateGbufferDepth = false;
                    }
                    // Create and declare the render targets used in the pass
                    for (int i = 0; i < gbufferAttachments.Length; ++i)
                    {
                        // Lighting buffer has already been declared with line ConfigureCameraTarget(m_ActiveCameraColorAttachment.Identifier(), ...) in DeferredRenderer.Setup
                        if (i == m_DeferredLights.GBufferLightingIndex)
                            continue;

                        // Normal buffer may have already been created if there was a depthNormal prepass before.
                        // DepthNormal prepass is needed for forward-only materials when SSAO is generated between gbuffer and deferred lighting pass.
                        if (i == m_DeferredLights.GBufferNormalSmoothnessIndex && m_DeferredLights.HasNormalPrepass)
                            continue;

                        if (i == m_DeferredLights.GbufferDepthIndex && !allocateGbufferDepth)
                            continue;

                        // No need to setup temporaryRTs if we are using input attachments as they will be Memoryless
                        if (m_DeferredLights.UseRenderPass
                            && i != m_DeferredLights.GBufferShadowMask
                            && i != m_DeferredLights.GBufferRenderingLayers
                            && i != m_DeferredLights.GbufferDepthIndex)
                            continue;

                        RenderTextureDescriptor gbufferSlice = cameraTextureDescriptor;
                        gbufferSlice.depthBufferBits = 0; // make sure no depth surface is actually created
                        gbufferSlice.stencilFormat = GraphicsFormat.None;
                        gbufferSlice.graphicsFormat = m_DeferredLights.GetGBufferFormat(i);
                        RenderingUtils.ReAllocateIfNeeded(ref m_DeferredLights.GbufferAttachments[i], gbufferSlice, FilterMode.Point, TextureWrapMode.Clamp, name: DeferredLights.k_GBufferNames[i]);
                        cmd.SetGlobalTexture(m_DeferredLights.GbufferAttachments[i].name, m_DeferredLights.GbufferAttachments[i].nameID);
                    }
                }

                if (m_DeferredLights.UseRenderPass)
                    m_DeferredLights.UpdateDeferredInputAttachments();

                ConfigureTarget(m_DeferredLights.GbufferAttachments, m_DeferredLights.DepthAttachment, m_DeferredLights.GbufferFormats);

                // We must explicitly specify we don't want any clear to avoid unwanted side-effects.
                // ScriptableRenderer will implicitly force a clear the first time the camera color/depth targets are bound.
                ConfigureClear(ClearFlag.None, Color.black);
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                CommandBuffer gbufferCommands = CommandBufferPool.Get();
                using (new ProfilingScope(gbufferCommands, m_ProfilingSampler))
                {
                    ScriptableRenderer.SetCameraMatrices(gbufferCommands, ref renderingData.cameraData, true);
                    context.ExecuteCommandBuffer(gbufferCommands);
                    gbufferCommands.Clear();

                    // User can stack several scriptable renderers during rendering but deferred renderer should only lit pixels added by this gbuffer pass.
                    // If we detect we are in such case (camera is in overlay mode), we clear the highest bits of stencil we have control of and use them to
                    // mark what pixel to shade during deferred pass. Gbuffer will always mark pixels using their material types.
                    if (m_DeferredLights.IsOverlay)
                    {
                        m_DeferredLights.ClearStencilPartial(gbufferCommands);
                        context.ExecuteCommandBuffer(gbufferCommands);
                        gbufferCommands.Clear();
                    }

                    ref CameraData cameraData = ref renderingData.cameraData;
                    Camera camera = cameraData.camera;
                    ShaderTagId lightModeTag = s_ShaderTagUniversalGBuffer;
                    DrawingSettings drawingSettings = CreateDrawingSettings(lightModeTag, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
                    ShaderTagId universalMaterialTypeTag = s_ShaderTagUniversalMaterialType;

                    NativeArray<ShaderTagId> tagValues = new NativeArray<ShaderTagId>(m_ShaderTagValues, Allocator.Temp);
                    NativeArray<RenderStateBlock> stateBlocks = new NativeArray<RenderStateBlock>(m_RenderStateBlocks, Allocator.Temp);

                    context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings, universalMaterialTypeTag, false, tagValues, stateBlocks);

                    tagValues.Dispose();
                    stateBlocks.Dispose();

                    // Render objects that did not match any shader pass with error shader
                    RenderingUtils.RenderObjectsWithError(context, ref renderingData.cullResults, camera, m_FilteringSettings, SortingCriteria.None);

                    // If any sub-system needs camera normal texture, make it available.
                    // Input attachments will only be used when this is not needed so safe to skip in that case
                    if (!m_DeferredLights.UseRenderPass)
                        gbufferCommands.SetGlobalTexture(s_CameraNormalsTextureID, m_DeferredLights.GbufferAttachments[m_DeferredLights.GBufferNormalSmoothnessIndex]);
                }

                context.ExecuteCommandBuffer(gbufferCommands);
                CommandBufferPool.Release(gbufferCommands);
            }
        }

        [System.Serializable]
        public class FeatureSettings
        {
            public string profilerTag = "Deferred_GBufferFeature";
            public LayerMask layerMask = -1;
            [Range(0, 5000)]
            public int RenderQueueStart = 0;
            [Range(0, 5000)]
            public int RenderQueueEnd = 5000;
            public StencilStateData stencilStateData = new StencilStateData();
            public bool hasNormalPrepass;
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
