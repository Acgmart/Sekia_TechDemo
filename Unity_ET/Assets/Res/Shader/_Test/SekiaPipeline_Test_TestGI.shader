Shader "SekiaPipeline/Test/TestGI"
{
    Properties
    {
        [Toggle(_NORMALMAP)]_NORMALMAP("_NORMALMAP", Int) = 0
        [NoScaleOffset]_NormalMap("法线贴图", 2D) = "bump" {}
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("剔除模式", Int) = 2
    }

    SubShader
    {
        Tags{ "RenderPipeline" = "UniversalPipeline" }

        Pass
        {
            Name "ForwardLit"
            Tags{ "LightMode" = "UniversalForward"}
			Cull [_CullMode]
            HLSLPROGRAM
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma shader_feature_local _ _NORMALMAP
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            CBUFFER_START(UnityPerMaterial)
            CBUFFER_END

            TEXTURE2D(_NormalMap);      SAMPLER(sampler_NormalMap);

half3 UnpackNormalNoScale(half4 packedNormal)
{
	#if defined(UNITY_ASTC_NORMALMAP_ENCODING)
		half3 normal;
		normal.xy = packedNormal.ag * half(2.0) - half(1.0);
		normal.z = sqrt(half(1.0) - saturate(dot(normal.xy, normal.xy)));
		return normal;
	#elif defined(UNITY_NO_DXT5nm)
		return packedNormal.rgb * half(2.0) - half(1.0);
	#else
		packedNormal.a *= packedNormal.r;
		half3 normal;
		normal.xy = packedNormal.ag * half(2.0) - half(1.0);
		normal.z = sqrt(half(1.0) - saturate(dot(normal.xy, normal.xy)));
		return normal;
	#endif
}

bool IsGammaSpace()
{
    #ifdef UNITY_COLORSPACE_GAMMA
        return true;
    #else
        return false;
    #endif
}

half3 Fast_SRGBToLinear(half3 c)
{
    //http://chilliant.blogspot.com/2012/08/srgb-approximations-for-hlsl.html
    return c * (c * (c * half(0.3053) + half(0.6822)) + half(0.01252));
}

half3 SampleSceneSH(half3 _NormalWS)
{
    //https://docs.unity3d.com/Manual/LightProbes-TechnicalInformation.html
    //forum.unity.com/threads/getinterpolatedlightprobe-interpreting-the-coefficients.461170/
    half3 x1; // Linear (L1) + constant (L0) polynomial terms
    half4 vA = half4(_NormalWS, 1.0);
    x1.r = dot(unity_SHAr, vA);
    x1.g = dot(unity_SHAg, vA);
    x1.b = dot(unity_SHAb, vA);

    half3 x2; // 4 of the quadratic (L2) polynomials
    half4 vB = _NormalWS.xyzz * _NormalWS.yzzx;
    x2.r = dot(unity_SHBr, vB);
    x2.g = dot(unity_SHBg, vB);
    x2.b = dot(unity_SHBb, vB);

    half vC = _NormalWS.x * _NormalWS.x - _NormalWS.y * _NormalWS.y;
    half3 x3 = unity_SHC.rgb * vC; // Final (5th) quadratic (L2) polynomial
    return x1 + x2 + x3;
}

//https://forum.unity.com/threads/hdr-cubemaps-questions.1170773/
//考虑下dLDR在Linear空间和Gamma空间的区别
//dLDR encode：HDR Image => to sRGB => clamp01 => * 0.5 => Store in 8bit sRGB
//dLDR decode in Linear: Sample(硬件To Linear) => * 2.0 ^ 2.2(即4.59)
//dLDR decode in Gamma : Sample => * 2.0 => 软件To Linear
//在两个颜色空间下进行线性光照计算时 他们是等价的：(2x)^2.2 = 4.59*(x^2.2)
half3 SampleLightmap_Encode(float2 lightmapUV)
{
	half4 encodedIlluminance = SAMPLE_TEXTURE2D(unity_Lightmap, samplerunity_Lightmap, lightmapUV);
    half3 irradiance = encodedIlluminance.rgb * LIGHTMAP_HDR_MULTIPLIER;
    irradiance = IsGammaSpace() ? Fast_SRGBToLinear(irradiance) : irradiance;
    return irradiance;
}
          
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
    half3 normalWS                  : TEXCOORD1;
    half4 tangentWS                 : TEXCOORD2;
    float4 uv0                      : TEXCOORD3;
};

v2f vert(a2v i)
{
    v2f o = (v2f)0;
    float3 positionWS = TransformObjectToWorld(i.positionOS);
    o.positionCS = TransformWorldToHClip(positionWS);
    o.uv0.xy = i.uv0;
    o.normalWS = TransformObjectToWorldNormal(i.normalOS); //已归一化应对模型缩放
    half sign = i.tangentOS.w * GetOddNegativeScale();
    half3 tangentWS = TransformObjectToWorldDir(i.tangentOS.xyz);
    o.tangentWS = half4(tangentWS, sign); //已归一化应对模型缩放
    #if defined(LIGHTMAP_ON)
        o.uv0.zw = i.uv1 * unity_LightmapST.xy + unity_LightmapST.zw;
    #endif
    return o;
}

half4 frag(v2f i) : SV_TARGET
{
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
    #if defined(_NORMALMAP)
        half3 _NormalWS = mul(normalTS, tangentToWorld);
    #else
        half3 _NormalWS = i.normalWS;
    #endif

    #if defined(LIGHTMAP_ON)
        half3 _BakedGI = SampleLightmap_Encode(i.uv0.xy);
    #else
        half3 _BakedGI = max(half(0.0), SampleSceneSH(_NormalWS));
    #endif
    return half4(_BakedGI, 1.0);
}

            ENDHLSL
        }
    }
}
