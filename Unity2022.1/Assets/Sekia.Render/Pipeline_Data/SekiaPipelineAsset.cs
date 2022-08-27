using System;
using System.IO;
using System.Linq;
using UnityEngine.Experimental.Rendering;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using ShadowResolution = UnityEngine.Rendering.Universal.ShadowResolution;
using ShadowQuality = UnityEngine.Rendering.Universal.ShadowQuality;
using TextureResources = UnityEngine.Rendering.Universal.PostProcessData.TextureResources;

namespace Sekia
{
    [ExcludeFromPreset]
    public class SekiaPipelineAsset : RenderPipelineAsset, ISerializationCallbackReceiver
    {
        public static SekiaPipelineAsset Instance;

        [Serializable]
        public class PipelineResources
        {
            //自定义的shader
            public Shader stencilDeferredPS;
            public Shader coreBlitPS;

            public Shader blitPS;
            public Shader copyDepthPS;
            public Shader samplingPS;
            public Shader fallbackErrorPS;
            public Shader fallbackLoadingPS;
            public Shader coreBlitColorAndDepthPS;
            public Shader cameraMotionVector;
            public Shader objectMotionVector;
        }

        #region 常规字段
        Shader m_DefaultShader;
        SekiaRenderer[] m_Renderers = new SekiaRenderer[1];

        // Renderer settings
        [SerializeField] internal SekiaRendererData[] m_RendererDataList = new SekiaRendererData[1];
        [SerializeField] internal int m_DefaultRendererIndex = 0;

        // General settings
        [SerializeField] Downsampling m_OpaqueDownsampling = Downsampling._2xBilinear;
        [SerializeField] bool m_SupportsTerrainHoles = true;

        // Quality settings
        [SerializeField] bool m_SupportsHDR = true;
        [SerializeField] MsaaQuality m_MSAA = MsaaQuality.Disabled;
        [SerializeField] float m_RenderScale = 1.0f;
        [SerializeField] bool m_FsrOverrideSharpness = false;
        [SerializeField] bool m_EnableLODCrossFade = true;

        // Main directional light Settings
        [SerializeField] LightRenderingMode m_MainLightRenderingMode = LightRenderingMode.PerPixel;
        [SerializeField] bool m_MainLightShadowsSupported = true;
        [SerializeField] ShadowResolution m_MainLightShadowmapResolution = ShadowResolution._2048;

        // Additional lights settings
        [SerializeField] LightRenderingMode m_AdditionalLightsRenderingMode = LightRenderingMode.PerPixel;
        [SerializeField] int m_AdditionalLightsPerObjectLimit = 4;
        [SerializeField] bool m_AdditionalLightShadowsSupported = false;
        [SerializeField] ShadowResolution m_AdditionalLightsShadowmapResolution = ShadowResolution._2048;

        [SerializeField] int m_AdditionalLightsShadowResolutionTierLow = UniversalRenderPipelineAsset.AdditionalLightsDefaultShadowResolutionTierLow;
        [SerializeField] int m_AdditionalLightsShadowResolutionTierMedium = UniversalRenderPipelineAsset.AdditionalLightsDefaultShadowResolutionTierMedium;
        [SerializeField] int m_AdditionalLightsShadowResolutionTierHigh = UniversalRenderPipelineAsset.AdditionalLightsDefaultShadowResolutionTierHigh;

        // Reflection Probes
        [SerializeField] bool m_ReflectionProbeBlending = false;
        [SerializeField] bool m_ReflectionProbeBoxProjection = false;

        // Shadows Settings
        [SerializeField] float m_ShadowDistance = 50.0f;
        [SerializeField] int m_ShadowCascadeCount = 1;
        [SerializeField] float m_Cascade2Split = 0.25f;
        [SerializeField] Vector2 m_Cascade3Split = new Vector2(0.1f, 0.3f);
        [SerializeField] Vector3 m_Cascade4Split = new Vector3(0.067f, 0.2f, 0.467f);
        [SerializeField] float m_CascadeBorder = 0.2f;
        [SerializeField] float m_ShadowDepthBias = 1.0f;
        [SerializeField] float m_ShadowNormalBias = 1.0f;
        [SerializeField] bool m_SoftShadowsSupported = false;
        [SerializeField] bool m_ConservativeEnclosingSphere = false;
        [SerializeField] int m_NumIterationsEnclosingSphere = 64;

        // Advanced settings
        [SerializeField] bool m_UseSRPBatcher = true;
        [SerializeField] bool m_SupportsDynamicBatching = false;
        [SerializeField] bool m_MixedLightingSupported = true;
        [SerializeField] bool m_SupportsLightLayers = false;
        [SerializeField][Obsolete] PipelineDebugLevel m_DebugLevel;
        [SerializeField] StoreActionsOptimization m_StoreActionsOptimization = StoreActionsOptimization.Auto;

        // Adaptive performance settings
        [SerializeField] bool m_UseAdaptivePerformance = true;

        // Post-processing settings
        [SerializeField] ColorGradingMode m_ColorGradingMode = ColorGradingMode.LowDynamicRange;
        [SerializeField] int m_ColorGradingLutSize = 32;
        [SerializeField] bool m_UseFastSRGBLinearConversion = false;

        [SerializeField] TextureResources m_Textures;

        //新增的用于直接访问的字段
        [SerializeField] public PipelineResources m_pipelineResources;
        [SerializeField] public PostProcessData postProcessData = null;
        #endregion //常规字段

#if UNITY_EDITOR
        //初次创建渲染配置
        [NonSerialized] internal UniversalRenderPipelineEditorResources m_EditorResourcesAsset;

        public static SekiaPipelineAsset Create()
        {
            // Create Universal RP Asset
            var instance = CreateInstance<SekiaPipelineAsset>();

            // Initialize default Renderer
            instance.m_EditorResourcesAsset = instance.editorResources;

            // Only enable for new URP assets by default
            instance.m_ConservativeEnclosingSphere = true;

            ResourceReloader.ReloadAllNullIn(instance, UniversalRenderPipelineAsset.packagePath);

            return instance;
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1812")]
        internal class CreateUniversalPipelineAsset : UnityEditor.ProjectWindowCallback.EndNameEditAction
        {
            public override void Action(int instanceId, string pathName, string resourceFile)
            {
                SekiaPipelineAsset pipelineAsset = Create();
                pipelineAsset.postProcessData = PostProcessData.GetDefaultPostProcessData();
                UnityEditor.AssetDatabase.CreateAsset(pipelineAsset, pathName);
                UnityEditor.Selection.activeObject = pipelineAsset;
            }
        }

        [UnityEditor.MenuItem("Assets/Create/Rendering/SekiaPipelineAsset", priority = CoreUtils.Sections.section2 + CoreUtils.Priorities.assetsCreateRenderingMenuPriority - 2)]
        static void CreateUniversalPipeline()
        {
            UnityEditor.ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0, CreateInstance<CreateUniversalPipelineAsset>(),
                  "SekiaPipelineAsset.asset", null, null);
        }

        internal static SekiaRendererData CreateRendererAsset(string path)
        {
            SekiaRendererData data = CreateInstance<SekiaRendererData>();
            UnityEditor.AssetDatabase.CreateAsset(data, path);
            ResourceReloader.ReloadAllNullIn(data, UniversalRenderPipelineAsset.packagePath);
            return data;
        }

        UniversalRenderPipelineEditorResources editorResources
        {
            get
            {
                if (m_EditorResourcesAsset != null && !m_EditorResourcesAsset.Equals(null))
                    return m_EditorResourcesAsset;

                string resourcePath = UnityEditor.AssetDatabase.GUIDToAssetPath(UniversalRenderPipelineAsset.editorResourcesGUID);
                var objs = UnityEditorInternal.InternalEditorUtility.LoadSerializedFileAndForget(resourcePath);
                m_EditorResourcesAsset = objs != null && objs.Length > 0 ? objs.First() as UniversalRenderPipelineEditorResources : null;
                return m_EditorResourcesAsset;
            }
        }
#endif


        protected override RenderPipeline CreatePipeline()
        {
            if (SekiaPipeline.Instance != null)
                return SekiaPipeline.Instance;

            if (m_RendererDataList == null)
            {
                Debug.LogError($"RendererData列表为空", this);
                return null;
            }

            if (m_RendererDataList[m_DefaultRendererIndex] == null)
            {
                int rendererDataLength = m_RendererDataList != null ? m_RendererDataList.Length : 0;
                Debug.LogError($"丢失默认Renderer实例 " +
                        $"RendererData长度:{rendererDataLength} " +
                        $"默认RendererDataIndex:{m_DefaultRendererIndex}", this);
                return null;
            }

            DestroyRenderers();
            SekiaPipeline.Instance = new SekiaPipeline(this);
            CreateRenderers();

            return SekiaPipeline.Instance;
        }

        public void DestroyRenderers()
        {
            if (m_Renderers == null)
                return;

            for (int i = 0; i < m_Renderers.Length; i++)
                DestroyRenderer(ref m_Renderers[i]);
        }

        void DestroyRenderer(ref SekiaRenderer renderer)
        {
            if (renderer != null)
            {
                renderer.OnDispose?.Invoke();
                renderer.OnDispose = null;
                renderer = null;
            }
        }

        protected override void OnValidate()
        {
            DestroyRenderers();

            // This will call RenderPipelineManager.CleanupRenderPipeline that in turn disposes the render pipeline instance and
            // assign pipeline asset reference to null
            base.OnValidate();
        }

        protected override void OnDisable()
        {
            DestroyRenderers();

            // This will call RenderPipelineManager.CleanupRenderPipeline that in turn disposes the render pipeline instance and
            // assign pipeline asset reference to null
            base.OnDisable();
        }

        void CreateRenderers()
        {
            if (m_Renderers != null)
            {
                for (int i = 0; i < m_Renderers.Length; ++i)
                {
                    if (m_Renderers[i] != null)
                        Debug.LogError($"Creating renderers but previous instance wasn't properly destroyed: m_Renderers[{i}]");
                }
            }

            //m_Renderers长度发生的变化时
            if (m_Renderers == null || m_Renderers.Length != m_RendererDataList.Length)
                m_Renderers = new SekiaRenderer[m_RendererDataList.Length];

            for (int i = 0; i < m_RendererDataList.Length; ++i)
            {
                if (m_RendererDataList[i] != null)
                {
                    m_Renderers[i] = m_RendererDataList[i].InternalCreateRenderer();

                }
            }
        }

        //获取默认Renderer实例
        public SekiaRenderer defaultRenderer
        {
            get
            {
                if (m_RendererDataList?.Length > m_DefaultRendererIndex && m_RendererDataList[m_DefaultRendererIndex] == null)
                {
                    int rendererDataLength = m_RendererDataList != null ? m_RendererDataList.Length : 0;
                    Debug.LogError($"丢失默认Renderer实例 \n" +
                        $"RendererData长度:{rendererDataLength}\n" +
                        $"默认RendererDataIndex:{m_DefaultRendererIndex}", this);
                    return null;
                }

                //用户修改了RendererData 需要重新实例化Renderer
                if (defaultRendererData.isInvalidated || m_Renderers[m_DefaultRendererIndex] == null)
                {
                    DestroyRenderer(ref m_Renderers[m_DefaultRendererIndex]);
                    m_Renderers[m_DefaultRendererIndex] = defaultRendererData.InternalCreateRenderer();
                }

                return m_Renderers[m_DefaultRendererIndex];
            }
        }

        //获取指定Renderer
        public SekiaRenderer GetRenderer(int index)
        {
            if (index == -1)
                index = m_DefaultRendererIndex;

            if (index >= m_RendererDataList.Length || index < 0 || m_RendererDataList[index] == null)
            {
                Debug.LogWarning(
                    $"Renderer at index {index.ToString()} is missing, falling back to Default Renderer {m_RendererDataList[m_DefaultRendererIndex].name}",
                    this);
                index = m_DefaultRendererIndex;
            }

            // RendererData list differs from RendererList. Create RendererList.
            if (m_Renderers == null || m_Renderers.Length < m_RendererDataList.Length)
            {
                DestroyRenderers();
                CreateRenderers();
            }

            // This renderer data is outdated or invalid, we recreate the renderer
            // so we construct all render passes with the updated data
            if (m_RendererDataList[index].isInvalidated || m_Renderers[index] == null)
            {
                DestroyRenderer(ref m_Renderers[index]);
                m_Renderers[index] = m_RendererDataList[index].InternalCreateRenderer();
            }

            return m_Renderers[index];
        }

        //获取默认RendererData
        internal SekiaRendererData defaultRendererData
        {
            get
            {
                if (m_RendererDataList[m_DefaultRendererIndex] == null)
                    Debug.LogError("默认RendererData为空", this);

                return m_RendererDataList[m_DefaultRendererIndex];
            }
        }

#if UNITY_EDITOR
        internal GUIContent[] rendererDisplayList
        {
            get
            {
                GUIContent[] list = new GUIContent[m_RendererDataList.Length + 1];
                list[0] = new GUIContent($"Default Renderer ({RendererDataDisplayName(m_RendererDataList[m_DefaultRendererIndex])})");

                for (var i = 1; i < list.Length; i++)
                {
                    list[i] = new GUIContent($"{(i - 1).ToString()}: {RendererDataDisplayName(m_RendererDataList[i - 1])}");
                }
                return list;
            }
        }

        string RendererDataDisplayName(SekiaRendererData data)
        {
            if (data != null)
                return data.name;

            return "NULL (Missing RendererData)";
        }
#endif

        internal int[] rendererIndexList
        {
            get
            {
                int[] list = new int[m_RendererDataList.Length + 1];
                for (int i = 0; i < list.Length; i++)
                {
                    list[i] = i - 1;
                }
                return list;
            }
        }

        /// <summary>
        /// Returns the downsampling method used when copying the camera color texture after rendering opaques.
        /// </summary>
        public Downsampling opaqueDownsampling
        {
            get { return m_OpaqueDownsampling; }
        }

        /// <summary>
        /// This settings controls if the asset <c>UniversalRenderPipelineAsset</c> supports terrain holes.
        /// </summary>
        /// <see href="https://docs.unity3d.com/Manual/terrain-PaintHoles.html"/>
        public bool supportsTerrainHoles
        {
            get { return m_SupportsTerrainHoles; }
        }

        /// <summary>
        /// Returns the active store action optimization value.
        /// </summary>
        /// <returns>Returns the active store action optimization value.</returns>
        public StoreActionsOptimization storeActionsOptimization
        {
            get { return m_StoreActionsOptimization; }
            set { m_StoreActionsOptimization = value; }
        }

        /// <summary>
        /// When enabled, the camera renders to HDR buffers. This setting can be overridden per camera.
        /// </summary>
        /// <see href="https://docs.unity3d.com/Manual/HDR.html"/>
        public bool supportsHDR
        {
            get { return m_SupportsHDR; }
            set { m_SupportsHDR = value; }
        }

        /// <summary>
        /// Specifies the msaa sample count used by this <c>UniversalRenderPipelineAsset</c>
        /// </summary>
        /// <see cref="SampleCount"/>
        public int msaaSampleCount
        {
            get { return (int)m_MSAA; }
            set { m_MSAA = (MsaaQuality)value; }
        }

        /// <summary>
        /// Specifies the render scale which scales the render target resolution used by this <c>UniversalRenderPipelineAsset</c>.
        /// </summary>
        public float renderScale
        {
            get { return m_RenderScale; }
            set { m_RenderScale = ValidateRenderScale(value); }
        }

        /// <summary>
        /// Returns true if the cross-fade style blending between the current LOD and the next LOD is enabled.
        /// </summary>
        public bool enableLODCrossFade
        {
            get { return m_EnableLODCrossFade; }
        }

        /// <summary>
        /// If this property is set to true, the value from the fsrSharpness property will control the intensity of the
        /// sharpening filter associated with FidelityFX Super Resolution.
        /// </summary>
        public bool fsrOverrideSharpness
        {
            get { return m_FsrOverrideSharpness; }
            set { m_FsrOverrideSharpness = value; }
        }

        /// <summary>
        /// Specifies the <c>LightRenderingMode</c> for the main light used by this <c>UniversalRenderPipelineAsset</c>.
        /// </summary>
        /// <see cref="LightRenderingMode"/>
        public LightRenderingMode mainLightRenderingMode
        {
            get { return m_MainLightRenderingMode; }
            internal set { m_MainLightRenderingMode = value; }
        }

        /// <summary>
        /// Specifies if objects lit by main light cast shadows.
        /// </summary>
        public bool supportsMainLightShadows
        {
            get { return m_MainLightShadowsSupported; }
            internal set { m_MainLightShadowsSupported = value; }
        }

        /// <summary>
        /// Returns the main light shadowmap resolution used for this <c>UniversalRenderPipelineAsset</c>.
        /// </summary>
        public int mainLightShadowmapResolution
        {
            get { return (int)m_MainLightShadowmapResolution; }
            internal set { m_MainLightShadowmapResolution = (ShadowResolution)value; }
        }

        /// <summary>
        /// Specifies the <c>LightRenderingMode</c> for the additional lights used by this <c>UniversalRenderPipelineAsset</c>.
        /// </summary>
        /// <see cref="LightRenderingMode"/>
        public LightRenderingMode additionalLightsRenderingMode
        {
            get { return m_AdditionalLightsRenderingMode; }
            internal set { m_AdditionalLightsRenderingMode = value; }
        }

        /// <summary>
        /// Specifies the maximum amount of per-object additional lights which can be used by this <c>UniversalRenderPipelineAsset</c>.
        /// </summary>
        public int maxAdditionalLightsCount
        {
            get { return m_AdditionalLightsPerObjectLimit; }
            set { m_AdditionalLightsPerObjectLimit = ValidatePerObjectLights(value); }
        }

        /// <summary>
        /// Specifies if objects lit by additional lights cast shadows.
        /// </summary>
        public bool supportsAdditionalLightShadows
        {
            get { return m_AdditionalLightShadowsSupported; }
            internal set { m_AdditionalLightShadowsSupported = value; }
        }

        /// <summary>
        /// Additional light shadows are rendered into a single shadow map atlas texture. This setting controls the resolution of the shadow map atlas texture.
        /// </summary>
        public int additionalLightsShadowmapResolution
        {
            get { return (int)m_AdditionalLightsShadowmapResolution; }
            internal set { m_AdditionalLightsShadowmapResolution = (ShadowResolution)value; }
        }

        /// <summary>
        /// Returns the additional light shadow resolution defined for tier "Low" in the UniversalRenderPipeline asset.
        /// </summary>
        public int additionalLightsShadowResolutionTierLow
        {
            get { return (int)m_AdditionalLightsShadowResolutionTierLow; }
            internal set { m_AdditionalLightsShadowResolutionTierLow = value; }
        }

        /// <summary>
        /// Returns the additional light shadow resolution defined for tier "Medium" in the UniversalRenderPipeline asset.
        /// </summary>
        public int additionalLightsShadowResolutionTierMedium
        {
            get { return (int)m_AdditionalLightsShadowResolutionTierMedium; }
            internal set { m_AdditionalLightsShadowResolutionTierMedium = value; }
        }

        /// <summary>
        /// Returns the additional light shadow resolution defined for tier "High" in the UniversalRenderPipeline asset.
        /// </summary>
        public int additionalLightsShadowResolutionTierHigh
        {
            get { return (int)m_AdditionalLightsShadowResolutionTierHigh; }
            internal set { m_AdditionalLightsShadowResolutionTierHigh = value; }
        }

        internal int GetAdditionalLightsShadowResolution(int additionalLightsShadowResolutionTier)
        {
            if (additionalLightsShadowResolutionTier <= UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierLow /* 0 */)
                return additionalLightsShadowResolutionTierLow;

            if (additionalLightsShadowResolutionTier == UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierMedium /* 1 */)
                return additionalLightsShadowResolutionTierMedium;

            if (additionalLightsShadowResolutionTier >= UniversalAdditionalLightData.AdditionalLightsShadowResolutionTierHigh /* 2 */)
                return additionalLightsShadowResolutionTierHigh;

            return additionalLightsShadowResolutionTierMedium;
        }

        /// <summary>
        /// Specifies if this <c>UniversalRenderPipelineAsset</c> should use Probe blending for the reflection probes in the scene.
        /// </summary>
        public bool reflectionProbeBlending
        {
            get { return m_ReflectionProbeBlending; }
            internal set { m_ReflectionProbeBlending = value; }
        }

        /// <summary>
        /// Specifies if this <c>UniversalRenderPipelineAsset</c> should allow box projection for the reflection probes in the scene.
        /// </summary>
        public bool reflectionProbeBoxProjection
        {
            get { return m_ReflectionProbeBoxProjection; }
            internal set { m_ReflectionProbeBoxProjection = value; }
        }

        /// <summary>
        /// Controls the maximum distance at which shadows are visible.
        /// </summary>
        public float shadowDistance
        {
            get { return m_ShadowDistance; }
            set { m_ShadowDistance = Mathf.Max(0.0f, value); }
        }

        /// <summary>
        /// Returns the number of shadow cascades.
        /// </summary>
        public int shadowCascadeCount
        {
            get { return m_ShadowCascadeCount; }
            set
            {
                if (value < UniversalRenderPipelineAsset.k_ShadowCascadeMinCount || value > UniversalRenderPipelineAsset.k_ShadowCascadeMaxCount)
                {
                    throw new ArgumentException($"Value ({value}) needs to be between {UniversalRenderPipelineAsset.k_ShadowCascadeMinCount} and {UniversalRenderPipelineAsset.k_ShadowCascadeMaxCount}.");
                }
                m_ShadowCascadeCount = value;
            }
        }

        /// <summary>
        /// Returns the split value.
        /// </summary>
        /// <returns>Returns a Float with the split value.</returns>
        public float cascade2Split
        {
            get { return m_Cascade2Split; }
            internal set { m_Cascade2Split = value; }
        }

        /// <summary>
        /// Returns the split values.
        /// </summary>
        /// <returns>Returns a Vector2 with the split values.</returns>
        public Vector2 cascade3Split
        {
            get { return m_Cascade3Split; }
            internal set { m_Cascade3Split = value; }
        }

        /// <summary>
        /// Returns the split values.
        /// </summary>
        /// <returns>Returns a Vector3 with the split values.</returns>
        public Vector3 cascade4Split
        {
            get { return m_Cascade4Split; }
            internal set { m_Cascade4Split = value; }
        }

        /// <summary>
        /// Last cascade fade distance in percentage.
        /// </summary>
        public float cascadeBorder
        {
            get { return m_CascadeBorder; }
            set { m_CascadeBorder = value; }
        }

        /// <summary>
        /// The Shadow Depth Bias, controls the offset of the lit pixels.
        /// </summary>
        public float shadowDepthBias
        {
            get { return m_ShadowDepthBias; }
            set { m_ShadowDepthBias = ValidateShadowBias(value); }
        }

        /// <summary>
        /// Controls the distance at which the shadow casting surfaces are shrunk along the surface normal.
        /// </summary>
        public float shadowNormalBias
        {
            get { return m_ShadowNormalBias; }
            set { m_ShadowNormalBias = ValidateShadowBias(value); }
        }

        /// <summary>
        /// Supports Soft Shadows controls the Soft Shadows.
        /// </summary>
        public bool supportsSoftShadows
        {
            get { return m_SoftShadowsSupported; }
            internal set { m_SoftShadowsSupported = value; }
        }

        /// <summary>
        /// Specifies if this <c>UniversalRenderPipelineAsset</c> should use dynamic batching.
        /// </summary>
        /// <see href="https://docs.unity3d.com/Manual/DrawCallBatching.html"/>
        public bool supportsDynamicBatching
        {
            get { return m_SupportsDynamicBatching; }
            set { m_SupportsDynamicBatching = value; }
        }

        /// <summary>
        /// Returns true if the Render Pipeline Asset supports mixed lighting, false otherwise.
        /// </summary>
        /// <see href="https://docs.unity3d.com/Manual/LightMode-Mixed.html"/>
        public bool supportsMixedLighting
        {
            get { return m_MixedLightingSupported; }
        }

        /// <summary>
        /// Returns true if the Render Pipeline Asset supports rendering layers for lights, false otherwise.
        /// </summary>
        public bool useRenderingLayers
        {
            get { return m_SupportsLightLayers; }
        }

        /// <summary>
        /// Specifies if SRPBacher is used by this <c>UniversalRenderPipelineAsset</c>.
        /// </summary>
        /// <see href="https://docs.unity3d.com/Manual/SRPBatcher.html"/>
        public bool useSRPBatcher
        {
            get { return m_UseSRPBatcher; }
            set { m_UseSRPBatcher = value; }
        }

        /// <summary>
        /// Returns the selected ColorGradingMode in the URP Asset.
        /// <see cref="ColorGradingMode"/>
        /// </summary>
        public ColorGradingMode colorGradingMode
        {
            get { return m_ColorGradingMode; }
            set { m_ColorGradingMode = value; }
        }

        /// <summary>
        /// Specifies the color grading LUT (lookup table) size in the URP Asset.
        /// </summary>
        public int colorGradingLutSize
        {
            get { return m_ColorGradingLutSize; }
            set { m_ColorGradingLutSize = Mathf.Clamp(value, UniversalRenderPipelineAsset.k_MinLutSize, UniversalRenderPipelineAsset.k_MaxLutSize); }
        }

        /// <summary>
        /// Returns true if fast approximation functions are used when converting between the sRGB and Linear color spaces, false otherwise.
        /// </summary>
        public bool useFastSRGBLinearConversion
        {
            get { return m_UseFastSRGBLinearConversion; }
        }

        /// <summary>
        /// Set to true to allow Adaptive performance to modify graphics quality settings during runtime.
        /// Only applicable when Adaptive performance package is available.
        /// </summary>
        public bool useAdaptivePerformance
        {
            get { return m_UseAdaptivePerformance; }
            set { m_UseAdaptivePerformance = value; }
        }

        /// <summary>
        /// Set to true to enable a conservative method for calculating the size and position of the minimal enclosing sphere around the frustum cascade corner points for shadow culling.
        /// </summary>
        public bool conservativeEnclosingSphere
        {
            get { return m_ConservativeEnclosingSphere; }
            set { m_ConservativeEnclosingSphere = value; }
        }

        /// <summary>
        /// Set the number of iterations to reduce the cascade culling enlcosing sphere to be closer to the absolute minimun enclosing sphere, but will also require more CPU computation for increasing values.
        /// This parameter is used only when conservativeEnclosingSphere is set to true. Default value is 64.
        /// </summary>
        public int numIterationsEnclosingSphere
        {
            get { return m_NumIterationsEnclosingSphere; }
            set { m_NumIterationsEnclosingSphere = value; }
        }

        #region 默认材质
        Material GetMaterial(DefaultMaterialType materialType)
        {
#if UNITY_EDITOR
            if (defaultRendererData == null || editorResources == null)
                return null;

            switch (materialType)
            {
                case DefaultMaterialType.Standard:
                    return editorResources.materials.lit;

                case DefaultMaterialType.Particle:
                    return editorResources.materials.particleLit;

                case DefaultMaterialType.Terrain:
                    return editorResources.materials.terrainLit;

                case DefaultMaterialType.Decal:
                    return editorResources.materials.decal;

                // Unity Builtin Default
                default:
                    return null;
            }
#else
            return null;
#endif
        }

        /// <summary>
        /// Returns the default Material.
        /// </summary>
        /// <returns>Returns the default Material.</returns>
        public override Material defaultMaterial
        {
            get { return GetMaterial(DefaultMaterialType.Standard); }
        }

        /// <summary>
        /// Returns the default particle Material.
        /// </summary>
        /// <returns>Returns the default particle Material.</returns>
        public override Material defaultParticleMaterial
        {
            get { return GetMaterial(DefaultMaterialType.Particle); }
        }

        /// <summary>
        /// Returns the default line Material.
        /// </summary>
        /// <returns>Returns the default line Material.</returns>
        public override Material defaultLineMaterial
        {
            get { return GetMaterial(DefaultMaterialType.Particle); }
        }

        /// <summary>
        /// Returns the default terrain Material.
        /// </summary>
        /// <returns>Returns the default terrain Material.</returns>
        public override Material defaultTerrainMaterial
        {
            get { return GetMaterial(DefaultMaterialType.Terrain); }
        }

        /// <summary>
        /// Returns the default UI Material.
        /// </summary>
        /// <returns>Returns the default UI Material.</returns>
        public override Material defaultUIMaterial
        {
            get { return GetMaterial(DefaultMaterialType.UnityBuiltinDefault); }
        }

        /// <summary>
        /// Returns the default UI overdraw Material.
        /// </summary>
        /// <returns>Returns the default UI overdraw Material.</returns>
        public override Material defaultUIOverdrawMaterial
        {
            get { return GetMaterial(DefaultMaterialType.UnityBuiltinDefault); }
        }

        /// <summary>
        /// Returns the default UIETC1 supported Material for this asset.
        /// </summary>
        /// <returns>Returns the default UIETC1 supported Material.</returns>
        public override Material defaultUIETC1SupportedMaterial
        {
            get { return GetMaterial(DefaultMaterialType.UnityBuiltinDefault); }
        }

        /// <summary>
        /// Returns the default material for the 2D renderer.
        /// </summary>
        /// <returns>Returns the material containing the default lit and unlit shader passes for sprites in the 2D renderer.</returns>
        public override Material default2DMaterial
        {
            get { return GetMaterial(DefaultMaterialType.Sprite); }
        }

        /// <summary>
        /// Returns the default sprite mask material for the 2D renderer.
        /// </summary>
        /// <returns>Returns the material containing the default shader pass for sprite mask in the 2D renderer.</returns>
        public override Material default2DMaskMaterial
        {
            get { return GetMaterial(DefaultMaterialType.SpriteMask); }
        }

        /// <summary>
        /// Returns the Material that Unity uses to render decals.
        /// </summary>
        /// <returns>Returns the Material containing the Unity decal shader.</returns>
        public Material decalMaterial
        {
            get { return GetMaterial(DefaultMaterialType.Decal); }
        }
        #endregion

        /// <summary>
        /// Returns the default shader for the specified renderer. When creating new objects in the editor, the materials of those objects will use the selected default shader.
        /// </summary>
        /// <returns>Returns the default shader for the specified renderer.</returns>
        public override Shader defaultShader
        {
            get
            {
#if UNITY_EDITOR
                if (m_DefaultShader == null)
                {
                    string path = UnityEditor.AssetDatabase.GUIDToAssetPath(ShaderUtils.GetShaderGUID(ShaderPathID.Lit));
                    m_DefaultShader = UnityEditor.AssetDatabase.LoadAssetAtPath<Shader>(path);
                }
#endif

                if (m_DefaultShader == null)
                    m_DefaultShader = Shader.Find(ShaderUtils.GetShaderPath(ShaderPathID.Lit));

                return m_DefaultShader;
            }
        }

        /// <summary>
        /// Returns asset texture resources
        /// </summary>
        public TextureResources textures
        {
            get
            {
                if (m_Textures == null)
                    m_Textures = new TextureResources();

#if UNITY_EDITOR
                ResourceReloader.ReloadAllNullIn(this, UniversalRenderPipelineAsset.packagePath);
#endif

                return m_Textures;
            }
        }

        public void OnBeforeSerialize()
        {
        }

        public void OnAfterDeserialize()
        {
        }

        float ValidateShadowBias(float value)
        {
            return Mathf.Max(0.0f, Mathf.Min(value, UniversalRenderPipeline.maxShadowBias));
        }

        int ValidatePerObjectLights(int value)
        {
            return System.Math.Max(0, System.Math.Min(value, UniversalRenderPipeline.maxPerObjectLights));
        }

        float ValidateRenderScale(float value)
        {
            return Mathf.Max(UniversalRenderPipeline.minRenderScale, Mathf.Min(value, UniversalRenderPipeline.maxRenderScale));
        }

        /// <summary>
        /// Check to see if the RendererData list contains valid RendererData references.
        /// </summary>
        /// <param name="partial">This bool controls whether to test against all or any, if false then there has to be no invalid RendererData</param>
        /// <returns></returns>
        internal bool ValidateRendererDataList(bool partial = false)
        {
            var emptyEntries = 0;
            for (int i = 0; i < m_RendererDataList.Length; i++) emptyEntries += ValidateRendererData(i) ? 0 : 1;
            if (partial)
                return emptyEntries == 0;
            return emptyEntries != m_RendererDataList.Length;
        }

        internal bool ValidateRendererData(int index)
        {
            // Check to see if you are asking for the default renderer
            if (index == -1) index = m_DefaultRendererIndex;
            return index < m_RendererDataList.Length ? m_RendererDataList[index] != null : false;
        }
    }
}
