
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

#if defined(_GBUFFER_PASS) && (defined(PLATFORM_SUPPORTS_NATIVE_RENDERPASS) || defined(SHADER_API_D3D11))
    #define _USE_RENDERPASS
#endif

CBUFFER_START(UnityPerMaterial)
half4   _BaseColor;
half    _Cutoff;
half    _MetallicCof;
half    _OcclusionCof;
half    _RoughnessCof;
half4   _EmissionColor;
CBUFFER_END

TEXTURE2D(_BaseMap);        SAMPLER(sampler_BaseMap);
TEXTURE2D(_MaskMap);        SAMPLER(sampler_MaskMap);
TEXTURE2D(_NormalMap);      SAMPLER(sampler_NormalMap);
TEXTURE2D(_SsaoTexture);    SAMPLER(sampler_SsaoTexture);

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

half3 ACESToneMapping(half3 x)
{
    //https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
    half a = 2.51;
    half b = 0.03;
    half c = 2.43;
    half d = 0.59;
    half e = 0.14;
    return (x * ( a * x + b)) / (x * (c * x + d) + e);
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

half3 EnvBRDFApprox(half3 _F0, half _PerceptualRoughness, half _NdotV)
{
    half4 c0 = half4(-1.0, -0.0275, -0.572, 0.022);
    half4 c1 = half4(1.0, 0.0425, 1.04, -0.04);
    half4 r = _PerceptualRoughness * c0 + c1;
    half a004 = min( r.x * r.x, exp2( half(-9.28) * _NdotV ) ) * r.x + r.y;
    half2 AB = half2( -1.04, 1.04 ) * a004 + r.zw;
    return _F0 * AB.x + AB.y;
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

half3 EnvironmentReflection(half3 _ReflectVector, half _PerceptualRoughness)
{
    #if !defined(_ENVIRONMENTREFLECTIONS_OFF)
        half mip = _PerceptualRoughness * (half(10.2) - half(4.2) *_PerceptualRoughness);
        half4 encodedIrradiance = SAMPLE_TEXTURECUBE_LOD(unity_SpecCube0, samplerunity_SpecCube0, _ReflectVector, mip);
        #if defined(UNITY_USE_NATIVE_HDR) || defined(UNITY_DOTS_INSTANCING_ENABLED)
            half3 irradiance = encodedIrradiance.rgb;
        #else
            //https://forum.unity.com/threads/hdr-cubemaps-questions.1170773/
            //使用LDR编码时需要解码 线性空间下不能完整还原
            half3 irradiance = DecodeHDREnvironment(encodedIrradiance, unity_SpecCube0_HDR);
        #endif
        irradiance = IsGammaSpace() ? Fast_SRGBToLinear(irradiance) : irradiance;
    return irradiance;
    #endif
    return _GlossyEnvironmentColor.rgb;
}

half D_GGX_NoPi(half3 _NormalWS, half3 _HalfDir, half a)
{
    half3 _NxH = cross(_NormalWS, _HalfDir);
    half _OneMinus_NdotH2 = dot(_NxH, _NxH);
    half _NdotH = saturate(dot(_NormalWS, _HalfDir));
    half n = _NdotH * a;
    half p = a / (_OneMinus_NdotH2 + n * n);
    return p * p;
}

half SchlickFresnel(half u)
{
    half m = saturate(half(1.0) - u);
    half m2 = m * m;
    return m2 * m2 * m;
}

half G_GeometrySmith(half _NdotL, half _NdotV,half _PerceptualRoughness)
{
    half r = _PerceptualRoughness + half(1.0);
    half k = r * r * half(0.125);
    half ggx1 = k + (half(1.0) - k) * _NdotL;
    half ggx2 = k + (half(1.0) - k) * _NdotV;
    return half(0.25) / (ggx1 * ggx2);
}

half G_SmithJointGGXVisibilityTerm(half _NdotL, half _NdotV, half a)
{
    //UnityStandardBRDF.cginc
    half lambdaV = _NdotL * (_NdotV * (half(1.0) - a) + a);
    half lambdaL = _NdotV * (_NdotL * (half(1.0) - a) + a);
    return half(0.5) / (lambdaV + lambdaL + half(0.001));
}

half3 DirectSpecularTerms(half _PerceptualRoughness, half3 _F0, half _NdotL, half _NdotV, 
    half3 _NormalWS, half3 _ViewDirWS, half3 _LightDirWS, half3 envirSpecular2)
{
    half a = _PerceptualRoughness * _PerceptualRoughness;
    half3 _HalfDir = normalize(_LightDirWS + _ViewDirWS);
    half _HdotV = saturate(dot(_HalfDir, _ViewDirWS));
    #if defined(_TEST) //DisneyBrdf
        half3 F = lerp(_F0, half3(1, 1, 1), SchlickFresnel(_HdotV));
        half D = D_GGX_NoPi(_NormalWS, _HalfDir, a);
        half G = G_GeometrySmith(_NdotL, _NdotV, _PerceptualRoughness);
        return F * G * D;
    #elif defined(_TEST1) //Unity builtin版近似G项
        half3 F = lerp(_F0, half3(1, 1, 1), SchlickFresnel(_HdotV));
        half D = D_GGX_NoPi(_NormalWS, _HalfDir, a);
        half G = G_SmithJointGGXVisibilityTerm(_NdotL, _NdotV, a);
        return F * G * D;
    #elif defined(_TEST2) //Unity URP Lit
        half _LdotH2 = max(half(0.1), _HdotV * _HdotV);
        half3 FV = _F0 / (_LdotH2 * (a * 4.0 + 2.0));
        half D = D_GGX_NoPi(_NormalWS, _HalfDir, a);
        return D * FV;
    #else  //UE4
        half D = D_GGX_NoPi(_NormalWS, _HalfDir, a);
        half b = _PerceptualRoughness * half(0.25) + half(0.25);
        return D * b * envirSpecular2;
    #endif
}

half3 DirectSpecularTerm(half3 _F0, half _NdotL, half _NdotV, half3 _NormalWS, 
    half3 _ViewDirWS, half3 _LightDirWS, half3 envirSpecular2, half _Roughness_a, half _Roughness_b)
{
    
    half3 _HalfDir = normalize(_LightDirWS + _ViewDirWS);
    half _HdotV = saturate(dot(_HalfDir, _ViewDirWS));
    half D = D_GGX_NoPi(_NormalWS, _HalfDir, _Roughness_a);
    return D * _Roughness_b * envirSpecular2;
}

half3 OneDirectLighting(half3 _LightColor, half3 _LightDirWS, half _NdotV, half3 _NormalWS, 
    half3 _ViewDirWS, half3 _Diffuse, half3 _F0, half3 envirSpecular2, half _Roughness_a, half _Roughness_b)
{
    half _NdotL = saturate(dot(_NormalWS, _LightDirWS));
    half3 diffuseTerm = _Diffuse;
    half3 specularTerm = DirectSpecularTerm(_F0, _NdotL, _NdotV, _NormalWS, 
        _ViewDirWS, _LightDirWS, envirSpecular2, _Roughness_a, _Roughness_b);
    return (diffuseTerm + specularTerm) * _LightColor * _NdotL;
}

half3 AllDirectLighting(float3 _PositionWS, half _NdotV, half3 _NormalWS, half3 _ViewDirWS,
    half3 _Diffuse, half3 _F0, half _PerceptualRoughness, half3 envirSpecular2)           
{
    float4 _ShadowCoord = TransformWorldToShadowCoord(_PositionWS);
    Light mainLight = GetMainLight(_ShadowCoord);
    mainLight.color *= mainLight.distanceAttenuation * mainLight.shadowAttenuation;
    half _Roughness_a =  _PerceptualRoughness * _PerceptualRoughness;
    half _Roughness_b = _PerceptualRoughness * half(0.25) + half(0.25);

    half3 _MainLighting = OneDirectLighting(mainLight.color, mainLight.direction,
        _NdotV, _NormalWS, _ViewDirWS, _Diffuse, _F0, envirSpecular2, _Roughness_a, _Roughness_b);

    half3 _AdditionalLighting = 0.0h;
    #if defined(_ADDITIONAL_LIGHTS)
        uint pixelLightCount = GetAdditionalLightsCount();
        for (uint lightIndex = 0u; lightIndex < pixelLightCount; ++lightIndex)
        {
            Light light = GetAdditionalLight(lightIndex, _PositionWS);
            light.color *= light.distanceAttenuation * light.shadowAttenuation;
            _AdditionalLighting += OneDirectLighting(light.color, light.direction,
            _NdotV, _NormalWS, _ViewDirWS, _Diffuse, _F0, envirSpecular2, _Roughness_a, _Roughness_b);
        }
    #endif

    return _MainLighting + _AdditionalLighting;
}

//https://johnwhite3d.blogspot.com/2017/10/signed-octahedron-normal-encoding.html
//传统的八面体编码浪费了一半的存储空间
//  编码后的xy值在2D uv的菱形两侧镜像 可以利用R10G10B10A2的A分量存储八面体顶点的z符号
//  将八面体顶点的xy值从-1~1 映射到 0~1 且充分利用八面体顶点坐标特性
//  通过额外的2bit 提高了性能 加倍了精度
half3 SignedOctEncode(half3 n)
{
    #if defined(_GBUFFER_NORMALS_OCT)
        n /= abs(n.x) + abs(n.y) + abs(n.z); //单位向量转化为八面体上的顶点
        half3 OutN;                          //abs(n.x) + abs(n.y) + abs(n.z) == 1
        half k = 0.5;
        OutN.y = n.y *  k  + k;
        OutN.x = n.x *  k  + OutN.y; //(n.y + n.x) * 0.5 + 0.5
        OutN.y = n.x * -k  + OutN.y; //(n.y - n.x) * 0.5 + 0.5
        OutN.z = saturate(n.z * half(32768.0));
        return OutN;
    #else
        return n * 0.5h + 0.5h;
    #endif
}

half3 SignedOctDecode(half3 n)
{
    #if defined(_GBUFFER_NORMALS_OCT)
        half3 OutN;
        OutN.x = n.x - n.y; //n.x
        OutN.y = n.x + n.y - half(1.0); //n.y
        OutN.z = n.z * half(2.0) - half(1.0);
        OutN.z = OutN.z * (half(1.0) - abs(OutN.x) - abs(OutN.y));
        return normalize(OutN);
    #else
        return n * half(2.0) - half(1.0);
    #endif
}
