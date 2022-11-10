#if defined(_ShadowCasterPass)
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
    float3 _LightDirection;
#endif

struct a2v
{
    float3 positionOS       : POSITION;
    #if defined(_ShadowCasterPass)
        float3 normalOS    : NORMAL;
    #endif
    #if defined(_HAIR_TRANS)
        half2 uv0               : TEXCOORD0;
    #endif
};

struct v2f
{
    half4 positionCS       : SV_POSITION;
    #if defined(_HAIR_TRANS)
        half2 uv0               : TEXCOORD0;
    #endif
};

v2f Vert(a2v i)
{
    v2f o = (v2f)0;
    float3 positionWS = TransformObjectToWorld(i.positionOS);

    #if defined(_ShadowCasterPass)                   
        float3 normalWS = TransformObjectToWorldNormal(i.normalOS);           
        o.positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, _LightDirection));
        #if UNITY_REVERSED_Z //近平面上方的阴影坠落
            o.positionCS.z = min(o.positionCS.z, o.positionCS.w * UNITY_NEAR_CLIP_VALUE);
        #else
            o.positionCS.z = max(o.positionCS.z, o.positionCS.w * UNITY_NEAR_CLIP_VALUE);
        #endif
    #else
        o.positionCS = TransformObjectToHClip(i.positionOS);
    #endif
    
    #if defined(_HAIR_TRANS)
        o.uv0 = i.uv0;
    #endif
    return o;
}

half4 Frag(v2f i) : SV_TARGET
{
    #if defined(_HAIR_TRANS)
        half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv0);
        clip(_BaseMapValue.a - _HairClipValue);
    #endif
    return 0.0h;
}