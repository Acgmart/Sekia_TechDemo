
using UnityEngine;
using UnityEngine.Rendering;
using Unity.Collections;
using System;
using System.Collections.Generic;
using UnityEngine.Rendering.Universal;
using UnityEngine.Experimental.Rendering;

namespace Sekia
{
    enum StencilUsage
    {
        UserMask = 0b_0000_1111,
        MaterialLit = 0b_0010_0000, //标记使用Lit光照模型的区域
    }

    public class GlobalData
    {
        public static GlobalData Instance = new GlobalData();

#if UNITY_SWITCH
        public const GraphicsFormat k_DepthStencilFormat = GraphicsFormat.D24_UNorm_S8_UInt;
        public const int k_DepthBufferBits = 24;
#else
        public const GraphicsFormat k_DepthStencilFormat = GraphicsFormat.D32_SFloat_S8_UInt;
        public const int k_DepthBufferBits = 32;
#endif
        public Mesh triangleMesh; //后处理全屏mesh 采样Y反转后的RT时 Y反转mesh的UV

        #region 定义RT
        public RenderTargetIdentifier activeColorTarget = BuiltinRenderTextureType.CameraTarget;
        public RenderTargetIdentifier activeDepthTarget = BuiltinRenderTextureType.CameraTarget;

        public RTHandle m_OpaqueColor; //copy产生颜色和深度
        public RTHandle m_DepthTexture;

        public RTHandle m_ColorGradingLut;
        public RTHandle m_MotionVectorColor;
        public RTHandle m_MotionVectorDepth;
        public RTHandle m_NormalsTexture;
        #endregion

        #region 定义性能分析采样器
        public static class Profiling
        {
            private static Dictionary<int, ProfilingSampler> s_HashSamplerCache = new Dictionary<int, ProfilingSampler>();
            public static readonly ProfilingSampler unknownSampler = new ProfilingSampler("Unknown");

            public static ProfilingSampler TryGetOrAddCameraSampler(Camera camera)
            {
#if UNITY_EDITOR
                ProfilingSampler ps;
                int cameraId = camera.GetHashCode();
                bool exists = s_HashSamplerCache.TryGetValue(cameraId, out ps);
                if (!exists)
                {
                    ps = new ProfilingSampler($"Camera: {camera.name}");
                    s_HashSamplerCache.Add(cameraId, ps);
                }
                return ps;
#else
                return unknownSampler;
#endif
            }

            public static ProfilingSampler TryGetOrAddSampler(string name)
            {
#if UNITY_EDITOR
                ProfilingSampler ps;
                int cameraId = name.GetHashCode();
                bool exists = s_HashSamplerCache.TryGetValue(cameraId, out ps);
                if (!exists)
                {
                    ps = new ProfilingSampler(name);
                    s_HashSamplerCache.Add(cameraId, ps);
                }
                return ps;
#else
                return unknownSampler;
#endif
            }
        }
        #endregion

        #region Shader预定义
        public static class ShaderKeywordStrings
        {
            public static readonly string _RENDER_PASS_ENABLED = "_RENDER_PASS_ENABLED";
            public static readonly string _GBUFFER_NORMALS_OCT = "_GBUFFER_NORMALS_OCT";

            public static readonly string _LINEAR_TO_SRGB_CONVERSION = "_LINEAR_TO_SRGB_CONVERSION";

            public static readonly string _ADDITIONAL_LIGHT_SHADOWS = "_ADDITIONAL_LIGHT_SHADOWS";
            public static readonly string _SHADOWS_SOFT = "_SHADOWS_SOFT";
            public static readonly string _DEFERRED_FIRST_LIGHT = "_DEFERRED_FIRST_LIGHT";
            public static readonly string _DEFERRED_MAIN_LIGHT = "_DEFERRED_MAIN_LIGHT";

            public static readonly string _DIRECTIONAL = "_DIRECTIONAL";
            public static readonly string _POINT = "_POINT";
            public static readonly string _SPOT = "_SPOT";
        }

        public static class ShaderPropertyIDs
        {
            //FinalBlit
            public static readonly int _BlitTexture = Shader.PropertyToID("_BlitTexture");

            //Deferred
            public static readonly int _MainLightPosition = Shader.PropertyToID("_MainLightPosition");
            public static readonly int _MainLightColor = Shader.PropertyToID("_MainLightColor");
            public static readonly int _MainLightLayerMask = Shader.PropertyToID("_MainLightLayerMask");

            public static readonly int _MainLightCookieTexture = Shader.PropertyToID("_MainLightCookieTexture");
            public static readonly int _MainLightWorldToLight = Shader.PropertyToID("_MainLightWorldToLight");
            public static readonly int _MainLightCookieTextureFormat = Shader.PropertyToID("_MainLightCookieTextureFormat");

            public static readonly int _AdditionalLightsCookieAtlasTexture = Shader.PropertyToID("_AdditionalLightsCookieAtlasTexture");
            public static readonly int _AdditionalLightsCookieAtlasTextureFormat = Shader.PropertyToID("_AdditionalLightsCookieAtlasTextureFormat");

            public static readonly int _AdditionalLightsCookieEnableBits = Shader.PropertyToID("_AdditionalLightsCookieEnableBits");

            public static readonly int _AdditionalLightsCookieAtlasUVRectBuffer = Shader.PropertyToID("_AdditionalLightsCookieAtlasUVRectBuffer");
            public static readonly int _AdditionalLightsCookieAtlasUVRects = Shader.PropertyToID("_AdditionalLightsCookieAtlasUVRects");

            public static readonly int _AdditionalLightsWorldToLightBuffer = Shader.PropertyToID("_AdditionalLightsWorldToLightBuffer");
            public static readonly int _AdditionalLightsLightTypeBuffer = Shader.PropertyToID("_AdditionalLightsLightTypeBuffer");

            public static readonly int _AdditionalLightsWorldToLights = Shader.PropertyToID("_AdditionalLightsWorldToLights");
            public static readonly int _AdditionalLightsLightTypes = Shader.PropertyToID("_AdditionalLightsLightTypes");

            //Forwad
            public static readonly int _MainLightOcclusionProbes = Shader.PropertyToID("_MainLightOcclusionProbes");
            public static readonly int _AdditionalLightsCount = Shader.PropertyToID("_AdditionalLightsCount");

            public static readonly int _AdditionalLightsPosition = Shader.PropertyToID("_AdditionalLightsPosition");
            public static readonly int _AdditionalLightsColor = Shader.PropertyToID("_AdditionalLightsColor");
            public static readonly int _AdditionalLightsAttenuation = Shader.PropertyToID("_AdditionalLightsAttenuation");
            public static readonly int _AdditionalLightsSpotDir = Shader.PropertyToID("_AdditionalLightsSpotDir");
            public static readonly int _AdditionalLightsOcclusionProbes = Shader.PropertyToID("_AdditionalLightsOcclusionProbes");
            public static readonly int _AdditionalLightsLayerMasks = Shader.PropertyToID("_AdditionalLightsLayerMasks");

            public static readonly int _AdditionalLightsBuffer = Shader.PropertyToID("_AdditionalLightsBuffer");
            public static readonly int _AdditionalLightsIndices = Shader.PropertyToID("_AdditionalLightsIndices");

            //DeferredLighting
            public static readonly int _LitStencilRef = Shader.PropertyToID("_LitStencilRef");
            public static readonly int _LitStencilReadMask = Shader.PropertyToID("_LitStencilReadMask");
            public static readonly int _LitStencilWriteMask = Shader.PropertyToID("_LitStencilWriteMask");
            public static readonly int _SimpleLitStencilRef = Shader.PropertyToID("_SimpleLitStencilRef");
            public static readonly int _SimpleLitStencilReadMask = Shader.PropertyToID("_SimpleLitStencilReadMask");
            public static readonly int _SimpleLitStencilWriteMask = Shader.PropertyToID("_SimpleLitStencilWriteMask");
            public static readonly int _StencilRef = Shader.PropertyToID("_StencilRef");
            public static readonly int _StencilReadMask = Shader.PropertyToID("_StencilReadMask");
            public static readonly int _StencilWriteMask = Shader.PropertyToID("_StencilWriteMask");
            public static readonly int _LitPunctualStencilRef = Shader.PropertyToID("_LitPunctualStencilRef");
            public static readonly int _LitPunctualStencilReadMask = Shader.PropertyToID("_LitPunctualStencilReadMask");
            public static readonly int _LitPunctualStencilWriteMask = Shader.PropertyToID("_LitPunctualStencilWriteMask");
            public static readonly int _SimpleLitPunctualStencilRef = Shader.PropertyToID("_SimpleLitPunctualStencilRef");
            public static readonly int _SimpleLitPunctualStencilReadMask = Shader.PropertyToID("_SimpleLitPunctualStencilReadMask");
            public static readonly int _SimpleLitPunctualStencilWriteMask = Shader.PropertyToID("_SimpleLitPunctualStencilWriteMask");
            public static readonly int _LitDirStencilRef = Shader.PropertyToID("_LitDirStencilRef");
            public static readonly int _LitDirStencilReadMask = Shader.PropertyToID("_LitDirStencilReadMask");
            public static readonly int _LitDirStencilWriteMask = Shader.PropertyToID("_LitDirStencilWriteMask");
            public static readonly int _SimpleLitDirStencilRef = Shader.PropertyToID("_SimpleLitDirStencilRef");
            public static readonly int _SimpleLitDirStencilReadMask = Shader.PropertyToID("_SimpleLitDirStencilReadMask");
            public static readonly int _SimpleLitDirStencilWriteMask = Shader.PropertyToID("_SimpleLitDirStencilWriteMask");

            public static readonly int _ScreenToWorld = Shader.PropertyToID("_ScreenToWorld");

            public static readonly int _SpotLightScale = Shader.PropertyToID("_SpotLightScale");
            public static readonly int _SpotLightBias = Shader.PropertyToID("_SpotLightBias");
            public static readonly int _SpotLightGuard = Shader.PropertyToID("_SpotLightGuard");
            public static readonly int _LightPosWS = Shader.PropertyToID("_LightPosWS");
            public static readonly int _LightColor = Shader.PropertyToID("_LightColor");
            public static readonly int _LightAttenuation = Shader.PropertyToID("_LightAttenuation");
            public static readonly int _LightOcclusionProbInfo = Shader.PropertyToID("_LightOcclusionProbInfo");
            public static readonly int _LightDirection = Shader.PropertyToID("_LightDirection");
            public static readonly int _ShadowLightIndex = Shader.PropertyToID("_ShadowLightIndex");

            //
            public static readonly int _GlossyEnvironmentColor = Shader.PropertyToID("_GlossyEnvironmentColor");
            public static readonly int _SubtractiveShadowColor = Shader.PropertyToID("_SubtractiveShadowColor");

            public static readonly int _GlossyEnvironmentCubeMap = Shader.PropertyToID("_GlossyEnvironmentCubeMap");
            public static readonly int _GlossyEnvironmentCubeMap_HDR = Shader.PropertyToID("_GlossyEnvironmentCubeMap_HDR");

            public static readonly int unity_AmbientSky = Shader.PropertyToID("unity_AmbientSky");
            public static readonly int unity_AmbientEquator = Shader.PropertyToID("unity_AmbientEquator");
            public static readonly int unity_AmbientGround = Shader.PropertyToID("unity_AmbientGround");

            public static readonly int _Time = Shader.PropertyToID("_Time");
            public static readonly int _SinTime = Shader.PropertyToID("_SinTime");
            public static readonly int _CosTime = Shader.PropertyToID("_CosTime");
            public static readonly int unity_DeltaTime = Shader.PropertyToID("unity_DeltaTime");
            public static readonly int _TimeParameters = Shader.PropertyToID("_TimeParameters");

            public static readonly int _ScaledScreenParams = Shader.PropertyToID("_ScaledScreenParams");
            public static readonly int _WorldSpaceCameraPos = Shader.PropertyToID("_WorldSpaceCameraPos");
            public static readonly int _ScreenParams = Shader.PropertyToID("_ScreenParams");
            public static readonly int _AlphaToMaskAvailable = Shader.PropertyToID("_AlphaToMaskAvailable");
            public static readonly int _ProjectionParams = Shader.PropertyToID("_ProjectionParams");
            public static readonly int _ZBufferParams = Shader.PropertyToID("_ZBufferParams");
            public static readonly int unity_OrthoParams = Shader.PropertyToID("unity_OrthoParams");
            public static readonly int _GlobalMipBias = Shader.PropertyToID("_GlobalMipBias");

            public static readonly int _ScreenSize = Shader.PropertyToID("_ScreenSize");
            public static readonly int _ScreenCoordScaleBias = Shader.PropertyToID("_ScreenCoordScaleBias");
            public static readonly int _ScreenSizeOverride = Shader.PropertyToID("_ScreenSizeOverride");

            public static readonly int unity_MatrixV = Shader.PropertyToID("unity_MatrixV");
            public static readonly int glstate_matrix_projection = Shader.PropertyToID("glstate_matrix_projection");
            public static readonly int unity_MatrixVP = Shader.PropertyToID("unity_MatrixVP");

            public static readonly int unity_MatrixInvV = Shader.PropertyToID("unity_MatrixInvV");
            public static readonly int unity_MatrixInvP = Shader.PropertyToID("unity_MatrixInvP");
            public static readonly int unity_MatrixInvVP = Shader.PropertyToID("unity_MatrixInvVP");

            public static readonly int unity_CameraProjection = Shader.PropertyToID("unity_CameraProjection");
            public static readonly int unity_CameraInvProjection = Shader.PropertyToID("unity_CameraInvProjection");
            public static readonly int unity_WorldToCamera = Shader.PropertyToID("unity_WorldToCamera");
            public static readonly int unity_CameraToWorld = Shader.PropertyToID("unity_CameraToWorld");

            public static readonly int unity_CameraWorldClipPlanes = Shader.PropertyToID("unity_CameraWorldClipPlanes");

            public static readonly int unity_BillboardNormal = Shader.PropertyToID("unity_BillboardNormal");
            public static readonly int unity_BillboardTangent = Shader.PropertyToID("unity_BillboardTangent");
            public static readonly int unity_BillboardCameraParams = Shader.PropertyToID("unity_BillboardCameraParams");

            public static readonly int _SourceTex = Shader.PropertyToID("_SourceTex");
            public static readonly int _ScaleBias = Shader.PropertyToID("_ScaleBias");
            public static readonly int _ScaleBiasRt = Shader.PropertyToID("_ScaleBiasRt");

            public static readonly int _DitheringTexture = Shader.PropertyToID("_DitheringTexture");
            public static readonly int _DitheringTextureInvSize = Shader.PropertyToID("_DitheringTextureInvSize");

            public static readonly int _RenderingLayerMaxInt = Shader.PropertyToID("_RenderingLayerMaxInt");
            public static readonly int _RenderingLayerRcpMaxInt = Shader.PropertyToID("_RenderingLayerRcpMaxInt");
        }

        public static class ShaderTagIds
        {
            public static readonly ShaderTagId UniversalGBuffer = new ShaderTagId("UniversalGBuffer");
            public static readonly ShaderTagId s_ShaderTagLit = new ShaderTagId("Lit");
            public static readonly ShaderTagId s_ShaderTagSimpleLit = new ShaderTagId("SimpleLit");
            public static readonly ShaderTagId s_ShaderTagUnlit = new ShaderTagId("Unlit");
            public static readonly ShaderTagId s_ShaderTagUniversalMaterialType = new ShaderTagId("UniversalMaterialType");
        }
        #endregion

        #region 材质球
        public Material m_BlitMaterial = null;
        public Material m_CopyDepthMaterial = null;
        public Material m_SamplingMaterial = null;
        public Material m_StencilDeferredMaterial = null;
        public Material m_CameraMotionVecMaterial = null;
        public Material m_ObjectMotionVecMaterial = null;
        #endregion

        #region 系统状态
        public Action OnDispose;
        public bool preserveFramebufferAlpha;
        public ColorSpace activeColorSpace;
        public GraphicsFormat ldrFormat;
        public GraphicsFormat hdrFormat;
        public GraphicsDeviceType graphicsDeviceType;
        public int graphicsShaderLevel;
        public bool IsGLESDevice;
        public bool IsGLDevice;
        public bool IsDX10;
        public int supportedRenderTargetCount;
        public const int DeferredRenderingNeedRenderTargetCount = 5;
        public const GraphicsFormat formatForPackedNormal = GraphicsFormat.A2B10G10R10_UNormPack32;
        public bool isPlaying;

        //功能支持
        public bool SystemSupporteDeferredRendering;
        public bool supportsShadows;

        //GPU特性
        public bool hasHSRonGPU; //光栅化后像素级排序 支持HSR时可以不用在意不透明物体的渲染顺序
        public SortingCriteria noFrontToBackOpaqueFlags;

        //平台差异
        public bool usesReversedZBuffer;
        public float nearClipZ;
        public bool graphicsUVStartsAtTop;

        //RT格式支持
        public static Dictionary<GraphicsFormat, Dictionary<FormatUsage, bool>> graphicsFormatSupport = new Dictionary<GraphicsFormat, Dictionary<FormatUsage, bool>>();
        #endregion

        public List<Vector4> m_ShadowBiasData = new List<Vector4>();
        public List<int> m_ShadowResolutionData = new List<int>();
    }

    public struct CameraData
    {
        //由Base相机提供的站内数据
        public bool useIntermediateRT;
        public bool useCopyColorRT;
        public bool useCopyDepthRT;
        public RenderTexture mainColorAttachment;
        public RenderTexture mainDepthAttachment;
        public RenderTexture copyColorAttachment;
        public RenderTexture copyDepthAttachment;

        //栈内状态
        public bool needFirstClearRT; //栈内 第一次对主目标进行渲染时需要清理目标
        public bool needSetViewPort; //Pass执行前 更换VP矩阵时要重新设置视口和VP矩阵
        public bool isTargetFlipped; //主RT是否需要Y反转 由baseCamera的renderer的Clear设置

        public Camera camera;
        public SekiaRenderer renderer;
        public RenderTextureDescriptor cameraTargetDescriptor; //用于创建中间RT
        public Matrix4x4 viewMatrix; //基于GL平台的V矩阵
        public Matrix4x4 projectionMatrix; //基于GL平台的P矩阵
        public CameraRenderType renderType;
        public CameraType cameraType;
        public RenderTexture targetTexture;
        public bool isHdrEnabled;
        public bool clearDepth;  //仅对Overlay相机有效

        internal Rect pixelRect;
        internal int pixelWidth;
        internal int pixelHeight;
        internal float aspectRatio;
        public bool isDefaultViewport;

        public float renderScale; //用于修改mainColor和mainDepth的分辨率
        internal bool fsrOverrideSharpness;
        internal float fsrSharpness;

        public bool requiresDepthTexture;
        public bool requiresOpaqueTexture;
        public bool postProcessingRequiresDepthTexture;

        public bool isSceneViewCamera => cameraType == CameraType.SceneView;
        public bool isPreviewCamera => cameraType == CameraType.Preview;
        internal bool isRenderPassSupportedCamera => (cameraType == CameraType.Game || cameraType == CameraType.Reflection);

        public SortingCriteria defaultOpaqueSortFlags;
        public float maxShadowDistance;
        public bool postProcessEnabled;
        public LayerMask volumeLayerMask;
        public Transform volumeTrigger;
        public bool isStopNaNEnabled;
        public bool isDitheringEnabled;
        public AntialiasingMode antialiasing;
        public AntialiasingQuality antialiasingQuality;
        public bool resolveFinalTarget;
        public Vector3 worldSpaceCameraPos;
        public Color backgroundColor;
        public bool cameraNeedSetupForwardLight;
    }

    public struct RenderingData
    {
        public CommandBuffer commandBuffer;
        public CullingResults cullResults;
        public CameraData cameraData;
        public LightData lightData;
        public ShadowData shadowData;
        public PostProcessingData postProcessingData;
        public bool supportsDynamicBatching;
        public PerObjectData perObjectData;
        public bool postProcessingEnabled;
    }
}
