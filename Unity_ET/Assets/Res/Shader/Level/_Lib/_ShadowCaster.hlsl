
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"

float3 _LightDirection;

struct a2v
{
    float4 positionOS   : POSITION;
    float3 normalOS     : NORMAL;
    float2 uv0     : TEXCOORD0;
};

struct v2f
{
    float2 uv0           : TEXCOORD0;
    float4 positionCS   : SV_POSITION;
};

float4 GetShadowPositionHClip(a2v i)
{
    float3 positionWS = TransformObjectToWorld(i.positionOS.xyz);
    float3 normalWS = TransformObjectToWorldNormal(i.normalOS);
    float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, _LightDirection));
#if UNITY_REVERSED_Z
    positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
#else
    positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
#endif
    return positionCS;
}

v2f vert(a2v i)
{
    v2f o = (v2f)0.0h;
    o.positionCS = GetShadowPositionHClip(i);
    #if defined(_ALPHATEST_ON)
        o.uv0 = i.uv0;
    #endif
    return o;
}

half4 frag(v2f i) : SV_TARGET
{
    #if defined(_ALPHATEST_ON)
        half4 baseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv0.xy);
        half _Alpha = baseMapValue.a * _BaseColor.a;
        clip(_Alpha - _Cutoff);
    #endif
    return 0;
}
