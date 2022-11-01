CBUFFER_START(UnityPerMaterial)
half4   _BaseColor;
half    _MetallicCof;
half    _OcclusionCof;
half    _RoughnessCof;
half4   _EmissionColor;

half4   _PositionWS_P;
half4   _NormalWS_P;
half4   _TangentWS_P;
half4   _ViewDirWS_P;

half4   _EnvirMap_HDR;
float4	_TestFloat;
CBUFFER_END

TEXTURE2D(_BaseMap);        SAMPLER(sampler_BaseMap);
TEXTURE2D(_MaskMap);        SAMPLER(sampler_MaskMap);
TEXTURE2D(_NormalMap);      SAMPLER(sampler_NormalMap);
TEXTURE2D(_LightMap);       SAMPLER(sampler_LightMap);
TEXTURECUBE(_EnvirMap);     SAMPLER(sampler_EnvirMap);

#include "_Lib/_SharedBrdfFunctions.hlsl"

struct a2v
{
	float3 positionOS 					: POSITION;
	half2 uv0 							: TEXCOORD0;
};

struct v2f
{
	float4 clipPos 						: SV_POSITION;
	half4 uv0 							: TEXCOORD0; //仅用于输出差值作为Alpha
};

v2f vert ( a2v i )
{
	v2f o = (v2f)0;
	float3 positionWS = TransformObjectToWorld(i.positionOS);
	float4 positionCS = TransformWorldToHClip(positionWS);
	o.uv0.xy = i.uv0.xy;
	o.clipPos = positionCS;
	return o;
}

half3 SampleLightmap_Encode_Local(float2 lightmapUV)
{
	half4 encodedIlluminance = SAMPLE_TEXTURE2D(_LightMap, sampler_LightMap, lightmapUV);
    half3 irradiance = encodedIlluminance.rgb * LIGHTMAP_HDR_MULTIPLIER;
    irradiance = IsGammaSpace() ? Fast_SRGBToLinear(irradiance) : irradiance;
    return irradiance;
}

half4 frag_Empty ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Empty_1 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Empty_2 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	_Color *= _EmissionColor.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Empty_3 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	_Color *= _EmissionColor.rgb;
	_Color *= _PositionWS_P.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Empty_4 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	_Color *= _EmissionColor.rgb;
	_Color *= _PositionWS_P.rgb;
	_Color *= _NormalWS_P.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample_1 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv0.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample_2 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv0.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.01;
	_BaseMapValue = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample_3 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv0.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.01;
	_BaseMapValue = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.01;
	_BaseMapValue = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample_4 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv0.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.01;
	_BaseMapValue = SAMPLE_TEXTURE2D(_MaskMap, sampler_MaskMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.01;
	_BaseMapValue = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.01;
	_BaseMapValue = SAMPLE_TEXTURE2D(_LightMap, sampler_LightMap, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_PBR ( v2f i  ) : SV_Target
{
    half3 positionWS = _PositionWS_P.xyz;
    half3 _normalWS = _NormalWS_P.xyz;
    half4 _tangentWS = _TangentWS_P.xyzw;
    half3 viewDirWS = _ViewDirWS_P.xyz;

    //BaseMap输入
    half4 baseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv0.xy);
    baseMapValue *= _BaseColor;
    half _Alpha = baseMapValue.a;
    half3 albedo = baseMapValue.rgb;

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
    half renormFactor = rcp(length(_normalWS));
    half3 bitangentWS = cross(_normalWS, _tangentWS.xyz) * _tangentWS.w;
    half3 tangentWS = _tangentWS.xyz * renormFactor;
    half3 normalWS = _normalWS * renormFactor;
    bitangentWS *= renormFactor;
    half3x3 tangentToWorld = half3x3(tangentWS, bitangentWS, normalWS);

    //DRBF数据
	#if defined(_NONORMALMAP)
    	half3 _NormalWS = _normalWS;
	#else
		half3 _NormalWS = mul(normalTS, tangentToWorld);
	#endif
    half3 _ReflectVector = reflect(-viewDirWS, _NormalWS);
    half _NdotV = saturate(dot(_NormalWS, viewDirWS));
    half _PerceptualRoughness = roughness;
    half _PerceptualSmoothness = half(1.0) - _PerceptualRoughness;
    half3 _Diffuse = albedo * (half(1.0) - metallic);
    half3 _F0 = lerp(half3(0.04, 0.04, 0.04), albedo, metallic);
    #if defined(LIGHTMAP_ON)
        half3 _BakedGI = SampleLightmap_Encode_Local(i.uv0.xy);
    #else
        half3 _BakedGI = max(half(0.0), SampleSceneSH(_NormalWS));
    #endif

    half _AO_envir = occlusion;
    half _AO_direct = 1.0;

    //环境光照
    half3 _EnvirDiffuse = _BakedGI * _Diffuse * _AO_envir;
    half3 envirSpecular1 = EnvironmentReflection(_ReflectVector, _PerceptualRoughness);
    half3 envirSpecular2 = EnvBRDFApprox(_F0, _PerceptualRoughness, _NdotV);
    half envirSpecularAO = lerp(_AO_envir, half(1.0), metallic * _PerceptualSmoothness * _PerceptualSmoothness);
    half3 _EnvirSpecular = envirSpecular1 * envirSpecular2 * envirSpecularAO;
    half3 _EnvirLighting = _EnvirDiffuse + _EnvirSpecular;

    //实时光照
    half3 _DirectLighting = AllDirectLighting(positionWS, _NdotV, _NormalWS, viewDirWS,
        _Diffuse, _F0, _PerceptualRoughness, envirSpecular2);
    _DirectLighting *= _AO_direct;

    half3 _EmmisionLighting = albedo * emission;
    
    half3 _Color = _EnvirLighting + _DirectLighting + _EmmisionLighting;
	#if !defined(_NOACES)
    	_Color = ACESToneMapping(_Color);
	#endif

    return half4(_Color, _Alpha);
}


float Fast_Log2 (float f)
{
    return (float (asuint (f)) / 8388608.0) - 127.0;
}

float Fast_Exp2 (float f)
{
    uint param = uint((f + 127.0) * 8388608.0);
    return asfloat (param);
}

float Fast_Pow(float fBase, float fPower)
{
    uint param_1 = uint((fPower * float(asuint(fBase))) - (((fPower - 1.0) * 127.0) * 8388608.0));
    return asfloat(param_1);
}

float3 Fast_Pow(float3 fBase, float3 fPower)
{
    uint3 param_1 = uint3((fPower * float3(asuint(fBase))) - (((fPower - 1.0) * 127.0) * 8388608.0));
    return asfloat(param_1);
}

half3 Fast_LinearToSRGB(half3 c)
{
    return saturate(half(1.055) * PositivePow(c, half(0.4167)) - half(0.055));
}

half4 frag_FastFunction1 ( v2f i  ) : SV_Target
{
    half3 positionWS = _PositionWS_P.xyz;
    half3 _Color1 = pow(positionWS, half(0.25));
	half3 _Color = _Color1;
    return half4(_Color, i.uv0.x);
}

half4 frag_FastFunction2 ( v2f i  ) : SV_Target
{
    half3 _normalWS = _NormalWS_P.xyz;
	half3 _Color2 = pow(_normalWS.x, half(0.25));
	half3 _Color = _Color2;
    return half4(_Color, i.uv0.x);
}

half4 frag_FastFunction3 ( v2f i  ) : SV_Target
{
	half3 _Color2 = Fast_Pow(_TestFloat.x, float(0.25));
	half3 _Color = _Color2;
    return half4(_Color, i.uv0.x);
}

half4 frag_FastFunction4 ( v2f i  ) : SV_Target
{
	half3 _Color3 = Fast_Pow(_TestFloat.xyz, float3(0.25, 0.25, 0.25));
	half3 _Color = _Color3;
    return half4(_Color, i.uv0.x);
}