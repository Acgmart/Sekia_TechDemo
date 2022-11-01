
struct a2v
{
    float3 positionOS               : POSITION;
    float3 normalOS                 : NORMAL;
    float4 tangentOS                : TANGENT;
    float2 uv0                      : TEXCOORD0;
    #if defined(LIGHTMAP_ON)
        float2 uv1                  : TEXCOORD1;
    #endif
};

struct v2f
{
    float4 positionCS               : SV_POSITION;
    float3 positionWS               : TEXCOORD0;
    half3 normalWS                  : TEXCOORD1;
    half4 tangentWS                 : TEXCOORD2;
    float4 uv0                      : TEXCOORD3;
	half3 viewDirWS					: TEXCOORD4;
};

v2f vert(a2v i)
{
    v2f o = (v2f)0;
    o.positionWS = TransformObjectToWorld(i.positionOS);
    o.positionCS = TransformWorldToHClip(o.positionWS);
    o.uv0.xy = i.uv0;
    o.normalWS = TransformObjectToWorldNormal(i.normalOS); //已归一化应对模型缩放
    half sign = i.tangentOS.w * GetOddNegativeScale();
    half3 tangentWS = TransformObjectToWorldDir(i.tangentOS.xyz);
    o.tangentWS = half4(tangentWS, sign); //已归一化应对模型缩放
    #if defined(LIGHTMAP_ON)
        o.uv0.zw = i.uv1 * unity_LightmapST.xy + unity_LightmapST.zw;
    #endif
	o.viewDirWS = normalize(_WorldSpaceCameraPos.xyz - o.positionWS);
    return o;
}

struct fragOutput
{
    #if defined(_GBUFFER_PASS)
        half4 GBuffer0 : SV_Target0;
        half4 GBuffer1 : SV_Target1;
        half4 GBuffer2 : SV_Target2;
        float GBuffer3 : SV_Target3; //copyDepth
    #else
        half4 _Color   : SV_TARGET;
    #endif
};

fragOutput frag(v2f i)
{
    //BaseMap输入
    half4 baseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv0.xy);
    half _Alpha = baseMapValue.a * _BaseColor.a;
    #if defined(_ALPHATEST_ON)
        clip(_Alpha - _Cutoff);
    #endif
    half3 albedo = baseMapValue.rgb * _BaseColor.rgb;

    //MaskMap输入
    half4 maskMapValue = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, i.uv0.xy);
    half metallic = maskMapValue.r * _MetallicCof;
    half roughness = clamp(maskMapValue.g * _RoughnessCof, half(0.12), half(1.0));
    half occlusion = lerp(half(1.0), maskMapValue.b, _OcclusionCof);
    half3 emission = maskMapValue.a * _EmissionColor.rgb;
    
    //法线贴图输入
    half4 normalMapValue = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, i.uv0.xy);
    half3 normalTS = UnpackNormalNoScale(normalMapValue);

    //基于surface gradient公式需要初始为归一化的法线
    //如果归一化由光栅化差值的法线会破坏mikkts 需要统一缩放三个向量
    half renormFactor = rcp(length(i.normalWS));
    half3 bitangentWS = cross(i.normalWS, i.tangentWS.xyz) * i.tangentWS.w;
    half3 tangentWS = i.tangentWS.xyz * renormFactor;
    half3 normalWS = i.normalWS * renormFactor;
    bitangentWS *= renormFactor;
    half3x3 tangentToWorld = half3x3(tangentWS, bitangentWS, normalWS);

    //DRBF数据
    half3 _NormalWS = mul(normalTS, tangentToWorld);
    half3 _ReflectVector = reflect(-i.viewDirWS, _NormalWS);
    half _NdotV = saturate(dot(_NormalWS, i.viewDirWS));
    half _PerceptualRoughness = roughness;
    half _PerceptualSmoothness = half(1.0) - _PerceptualRoughness;
    half3 _Diffuse = albedo * (half(1.0) - metallic);
    half3 _F0 = lerp(half3(0.04, 0.04, 0.04), albedo, metallic);
    #if defined(LIGHTMAP_ON)
        half3 _BakedGI = SampleLightmap_Encode(i.uv0.xy);
    #else
        half3 _BakedGI = max(half(0.0), SampleSceneSH(_NormalWS));
    #endif
    #if defined(_SCREEN_SPACE_OCCLUSION)
        float2 screenUV = i.positionCS.xy * _ScreenSize.zw; //左下角为(0, 0)
        half ssao = SAMPLE_TEXTURE2D(_SsaoTexture, sampler_SsaoTexture, screenUV).r;
        half _AO_envir = min(ssao, occlusion);
        half _AO_direct = lerp(half(1.0), ssao, _AmbientOcclusionParam.w);
    #else
        half _AO_envir = occlusion;
        half _AO_direct = 1.0;
    #endif

    //环境光照
    half3 _EnvirDiffuse = _BakedGI * _Diffuse * _AO_envir;
    half3 envirSpecular1 = EnvironmentReflection(_ReflectVector, _PerceptualRoughness);
    half3 envirSpecular2 = EnvBRDFApprox(_F0, _PerceptualRoughness, _NdotV);
    half envirSpecularAO = lerp(_AO_envir, half(1.0), metallic * _PerceptualSmoothness * _PerceptualSmoothness);
    half3 _EnvirSpecular = envirSpecular1 * envirSpecular2 * envirSpecularAO;
    half3 _EnvirLighting = _EnvirDiffuse + _EnvirSpecular;

    //实时光照
    half3 _DirectLighting = AllDirectLighting(i.positionWS, _NdotV, _NormalWS, i.viewDirWS,
        _Diffuse, _F0, _PerceptualRoughness, envirSpecular2);
    _DirectLighting *= _AO_direct;

    half3 _EmmisionLighting = albedo * emission;
    
    half3 _Color = _EnvirLighting + _DirectLighting + _EmmisionLighting;
    _Color = ACESToneMapping(_Color);

    fragOutput output;
    #if defined(_GBUFFER_PASS)
        output.GBuffer0 = half4(albedo,  metallic);
        output.GBuffer1 = half4(_EnvirLighting, occlusion);
        output.GBuffer2 = half4(roughness, SignedOctEncode(_NormalWS));
        output.GBuffer3 = i.positionCS.z;
    #else
        output._Color = half4(_Color, 1.0);
    #endif
    return output;
}
