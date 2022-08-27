
struct a2v
{
    float3 positionOS               : POSITION;
    float3 normalOS                 : NORMAL;
    float4 tangentOS                : TANGENT;
    float2 uv0                      : TEXCOORD0;
    #if defined(DYNAMICLIGHTMAP_ON)
        float2 dynamicLightmapUV    : TEXCOORD2;
    #endif
};

struct v2f
{
    float4 positionCS               : SV_POSITION;
    float3 positionWS               : TEXCOORD0;
    float3 normalWS                 : TEXCOORD1;
    float4 tangentWS                : TEXCOORD2;
    float4 uv0                      : TEXCOORD3;
};

v2f vert(a2v i)
{
    v2f o = (v2f)0;
    o.positionWS = TransformObjectToWorld(i.positionOS);
    o.positionCS = TransformWorldToHClip(o.positionWS);
    o.uv0.xy = i.uv0;
    o.normalWS = TransformObjectToWorldNormal(i.normalOS); //已归一化应对模型缩放
    float sign = i.tangentOS.w * GetOddNegativeScale();
    float3 tangentWS = TransformObjectToWorldDir(i.tangentOS.xyz);
    o.tangentWS = float4(tangentWS, sign); //已归一化应对模型缩放
    #if defined(DYNAMICLIGHTMAP_ON)
        o.uv0.zw = i.dynamicLightmapUV.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
    #endif
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
    half occlusion = lerp(1.0h, maskMapValue.g, _OcclusionCof);
    half roughness = clamp(maskMapValue.b * _RoughnessCof, 0.12h, 1.0h);
    half3 emission = maskMapValue.a * _EmissionColor.rgb;
    
    //法线贴图输入
    half4 normalMapValue = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, i.uv0.xy);
    half3 normalTS = UnpackNormal(normalMapValue);

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
    half3 _ViewDirWS = normalize(_WorldSpaceCameraPos.xyz - i.positionWS);
    half3 _ReflectVector = reflect(-_ViewDirWS, _NormalWS);
    half _NdotV = saturate(dot(_NormalWS, _ViewDirWS));
    half _PerceptualRoughness = roughness;
    half _PerceptualSmoothness = 1.0h - _PerceptualRoughness;
    half3 _Diffuse = albedo * (1.0h - metallic);
    half3 _F0 = lerp(0.04h, albedo, metallic);
    #if defined(DYNAMICLIGHTMAP_ON)
        //dynamic lightmap使用RGB9E5: RGB共享5位指数尾数分别各自用9位 合起来32位表示3个half
        half3 _BakedGI = SAMPLE_TEXTURE2D(unity_DynamicLightmap, samplerunity_DynamicLightmap, i.uv0.zw).rgb;
    #else
        half3 _BakedGI = max(0.0h, SampleSceneSH(_NormalWS));
    #endif
    #if defined(_SCREEN_SPACE_OCCLUSION)
        float2 screenUV = i.positionCS.xy * _ScreenSize.zw; //左下角为(0, 0)
        half ssao = SAMPLE_TEXTURE2D(_SsaoTexture, sampler_SsaoTexture, screenUV).r;
        half _AO_envir = min(ssao, occlusion);
        half _AO_direct = lerp(1.0h, ssao, _AmbientOcclusionParam.w);
    #else
        half _AO_envir = occlusion;
        half _AO_direct = 1.0h;
    #endif

    //环境光照
    half3 _EnvirDiffuse = _BakedGI * _Diffuse * _AO_envir;
    half3 envirSpecular1 = EnvironmentReflection(_ReflectVector, _PerceptualRoughness);
    half3 envirSpecular2 = EnvBRDFApprox(_F0, _PerceptualRoughness, _NdotV);
    half envirSpecularAO = lerp(_AO_envir, 1.0h, metallic * _PerceptualSmoothness * _PerceptualSmoothness);
    half3 _EnvirSpecular = envirSpecular1 * envirSpecular2 * envirSpecularAO;
    half3 _EnvirLighting = _EnvirDiffuse + _EnvirSpecular;

    //实时光照
    half3 _DirectLighting = AllDirectLighting(i.positionWS, _NdotV, _NormalWS, _ViewDirWS,
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
        output._Color = half4(_Color, 1.0h);
    #endif
    return output;
}
