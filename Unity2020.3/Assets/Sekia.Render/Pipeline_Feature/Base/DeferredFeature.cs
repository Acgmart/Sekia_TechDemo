using UnityEngine.Experimental.Rendering;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Rendering;
using System.Collections.Generic;
using System;

namespace Sekia
{
    [ExcludeFromPreset]
    public abstract class SekiaSubPass : ScriptableObject
    {
#if UNITY_EDITOR
        [NonSerialized]
        bool isSecondInit = false; //仅用于编辑器下修改属性时快速更新

        void OnValidate()
        {
            if (isSecondInit)
                Init();
            if (!isSecondInit)
                isSecondInit = true;
        }
#endif

        public abstract void Init();

        public abstract void ExecuteSubPass(ScriptableRenderContext context, ref RenderingData renderingData);
    }

    public enum GBufferType
    {
        LDR,
        HDR,
        PBR,
        Normal,
        DepthR,
    }

    public class DeferredFeature : SekiaRendererFeature
    {
        public class FeaturePass : SekiaRendererPass
        {
            FeatureSettings settings;
            GlobalData ins;
            public bool usePackedNormal = true;
            public int groupGBufferCount;
            public int groupSubPassCount;

            public const int maxSubPassCount = 10;
            public readonly NativeArray<int>[] subPassColorAIs = new NativeArray<int>[maxSubPassCount];
            public readonly NativeArray<int>[] subPassInputAIs = new NativeArray<int>[maxSubPassCount];

            public readonly AttachmentDescriptor[] groupColorADs = new AttachmentDescriptor[8];
            public AttachmentDescriptor groupDepthAD;

            private GraphicsFormat GetGBufferFormat(GBufferType type)
            {
                if (type == GBufferType.LDR)                    //RGB颜色+A数据 保存在Gamma空间可提高数值精度
                    return ins.ldrFormat;
                else if (type == GBufferType.HDR)
                    return ins.hdrFormat;
                else if (type == GBufferType.PBR)               //RGBA数据
                    return GraphicsFormat.R8G8B8A8_UNorm;
                else if (type == GBufferType.Normal)            //RGB法线+A数据
                    return usePackedNormal ? GlobalData.formatForPackedNormal : GraphicsFormat.R8G8B8A8_UNorm;
                else if (type == GBufferType.DepthR)
                    return GraphicsFormat.R32_SFloat;
                else
                    return GraphicsFormat.None;
            }

            public FeaturePass(FeatureSettings settings)
            {
                this.settings = settings;
                this.ins = GlobalData.Instance;
            }

            public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                Configure(context, ref renderingData);

                for (int i = 0; i < groupSubPassCount; ++i)
                    ExecuteNativeRenderPass(i, context, ref renderingData);
            }

            private void Configure(ScriptableRenderContext context, ref RenderingData renderingData)
            {
                var cmd = renderingData.commandBuffer;
                using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("Deferred.Configure"));

                var nativeGroupSettings = settings.nativeGroupSettings;
                var nativeSubPassSettings = settings.nativeSubPassSettings;
                ref var cameraData = ref renderingData.cameraData;
                var renderer = cameraData.renderer;

                usePackedNormal = nativeGroupSettings.packNormal;
                groupSubPassCount = nativeSubPassSettings.subPasseSettings.Count;
                groupGBufferCount = nativeGroupSettings.groupAttachments.Count;

                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._GBUFFER_NORMALS_OCT, usePackedNormal);
                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._RENDER_PASS_ENABLED, true);

                RTClearFlags cameraClearFlag = GlobalLogic.GetCameraClearFlag(ref cameraData);

                for (int i = 0; i < groupGBufferCount; ++i)
                {
                    var groupAttachment = nativeGroupSettings.groupAttachments[i];
                    AttachmentDescriptor grouAD = new AttachmentDescriptor(GetGBufferFormat(groupAttachment));

                    if (i == nativeGroupSettings.mainColorIndex)
                    {
                        if (cameraData.useIntermediateRT)
                        {
                            RenderTargetIdentifier target = cameraData.mainColorAttachment;
                            target = new RenderTargetIdentifier(target, 0, CubemapFace.Unknown, -1);
                            grouAD.loadStoreTarget = target;
                        }
                        else
                        {
                            RenderTargetIdentifier target = (cameraData.targetTexture != null) ?
                                cameraData.targetTexture : BuiltinRenderTextureType.CameraTarget;
                            target = new RenderTargetIdentifier(target, 0, CubemapFace.Unknown, -1);
                            grouAD.loadStoreTarget = target;
                        }

                        grouAD.storeAction = RenderBufferStoreAction.Store;
                        if ((cameraClearFlag & RTClearFlags.Color) != 0)
                            grouAD.ConfigureClear(cameraData.backgroundColor, 1.0f, 0u);
                    }
                    else if (i == nativeGroupSettings.copyDepthIndex)
                    {
                        if (cameraData.useCopyDepthRT)
                        {
                            RenderTargetIdentifier target = cameraData.copyDepthAttachment;
                            target = new RenderTargetIdentifier(target, 0, CubemapFace.Unknown, -1);
                            grouAD.loadStoreTarget = target;
                            grouAD.storeAction = RenderBufferStoreAction.Store;
                        }
                        grouAD.ConfigureClear(Color.clear, 1.0f, 0u);
                    }

                    groupColorADs[i] = grouAD;
                }

                {
                    //在FrameDebug上会显示ClearColor(1,0,0,0) ClearDepth 0
                    groupDepthAD = new AttachmentDescriptor(GlobalData.k_DepthStencilFormat);
                    if ((cameraClearFlag & RTClearFlags.DepthStencil) != 0)
                        groupDepthAD.ConfigureClear(Color.clear, 1.0f, 0u);
                }

                for (int i = 0; i < groupSubPassCount; ++i)
                {
                    var subPassSetting = nativeSubPassSettings.subPasseSettings[i];
                    int colorAttachmentCount = subPassSetting.colorAttachments.Count;
                    int inputAttachmentCount = subPassSetting.inputAttachments.Count;

                    //申请内存后不读取内容 直接重新写入 所以无需初始化内存
                    var subPassCAIs = new NativeArray<int>(colorAttachmentCount, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
                    var subPassIAIs = new NativeArray<int>(inputAttachmentCount, Allocator.Temp, NativeArrayOptions.UninitializedMemory);

                    for (int k = 0; k < colorAttachmentCount; ++k)
                        subPassCAIs[k] = subPassSetting.colorAttachments[k];

                    for (int k = 0; k < inputAttachmentCount; ++k)
                        subPassIAIs[k] = subPassSetting.inputAttachments[k];

                    subPassColorAIs[i] = subPassCAIs;
                    subPassInputAIs[i] = subPassIAIs;
                }

                profScope.Dispose();
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            private void ExecuteNativeRenderPass(int subPassIndex, ScriptableRenderContext context, ref RenderingData renderingData)
            {
                var cmd = renderingData.commandBuffer;
                using var profScope = new ProfilingScope(cmd, GlobalData.Profiling.TryGetOrAddSampler("Deferred.ExecuteSubPass"));
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                var colors = subPassColorAIs[subPassIndex];
                var inputs = subPassInputAIs[subPassIndex];
                bool hasInput = inputs.Length > 0;

                if (subPassIndex == 0)
                {
                    if (hasInput)
                        Debug.LogWarning("第一个SubPass不能有input attachments.");

                    var attachments = new NativeArray<AttachmentDescriptor>(groupGBufferCount + 1, Allocator.Temp);
                    for (int i = 0; i < groupGBufferCount; ++i)
                        attachments[i] = groupColorADs[i];
                    attachments[groupGBufferCount] = groupDepthAD;

                    var desc = renderingData.cameraData.cameraTargetDescriptor;
                    context.BeginRenderPass(desc.width, desc.height, 1, attachments, groupGBufferCount);
                    attachments.Dispose();

                    context.BeginSubPass(colors);
                }
                else
                {
                    context.EndSubPass();
                    if (hasInput)
                        context.BeginSubPass(colors, inputs);
                    else
                        context.BeginSubPass(colors);
                }

                colors.Dispose();
                inputs.Dispose();

                var subPass = settings.nativeSubPassSettings.subPasseSettings[subPassIndex].subPass;
                subPass.ExecuteSubPass(context, ref renderingData);

                if (groupSubPassCount - 1 == subPassIndex)
                {
                    context.EndSubPass();
                    context.EndRenderPass();
                }

                profScope.Dispose();
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();
            }

            public override void OnCameraCleanup(CommandBuffer cmd)
            {
                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._GBUFFER_NORMALS_OCT, false);
                CoreUtils.SetKeyword(cmd, GlobalData.ShaderKeywordStrings._RENDER_PASS_ENABLED, false);
            }
        }

        #region Feature设置
        [System.Serializable]
        public class NativeGroupSettings
        {
            public List<GBufferType> groupAttachments = new List<GBufferType>();
            public bool packNormal = true;
            [Range(0, 7)]
            public int mainColorIndex = 3;
            [Range(0, 7)]
            public int copyDepthIndex = 4;
        }

        [System.Serializable]
        public class SubPassSetting
        {
            public List<int> colorAttachments = new List<int>();
            public List<int> inputAttachments = new List<int>();
            public SekiaSubPass subPass = null;
        }

        [System.Serializable]
        public class NativesSubPassSettings
        {
            public List<SubPassSetting> subPasseSettings = new List<SubPassSetting>();
        }

        [System.Serializable]
        public class FeatureSettings
        {
            [Space]
            public NativeGroupSettings nativeGroupSettings = new NativeGroupSettings();

            [Space]
            public NativesSubPassSettings nativeSubPassSettings = new NativesSubPassSettings();
        }

        public FeatureSettings settings = new FeatureSettings();
        FeaturePass pass;

        public override void Init()
        {
            pass = new FeaturePass(settings);
            int subPassCount = settings.nativeSubPassSettings.subPasseSettings.Count;
            for (int i = 0; i < subPassCount; ++i)
            {
                SekiaSubPass subPass = settings.nativeSubPassSettings.subPasseSettings[i].subPass;
                subPass.Init();
            }
        }

        public override void AddRenderPasses(SekiaRenderer renderer, ref RenderingData renderingData)
        {
#if UNITY_EDITOR
            int mrtCount = settings.nativeGroupSettings.groupAttachments.Count;
            if (mrtCount > GlobalData.Instance.supportedRenderTargetCount)
            {
                renderer.useRenderPass = false;
                Debug.LogError($"MRT数量为{mrtCount} 超过系统限制值{GlobalData.Instance.supportedRenderTargetCount}");
            }

            int groupSubPassCount = settings.nativeSubPassSettings.subPasseSettings.Count;
            if (groupSubPassCount > FeaturePass.maxSubPassCount)
                Debug.LogError($"SubPass数量为{groupSubPassCount} 超过最大限制{FeaturePass.maxSubPassCount}");
#endif

            bool useRenderPass = renderer.useRenderPass;
#if UNITY_EDITOR
            useRenderPass &= renderingData.cameraData.isRenderPassSupportedCamera;
#endif
            if (useRenderPass)
                renderer.activeRenderPassQueue.Add(pass);
        }
        #endregion
    }
}
