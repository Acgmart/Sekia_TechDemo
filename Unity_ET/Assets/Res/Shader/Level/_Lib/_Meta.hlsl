CBUFFER_START(UnityMetaPass)
    bool4 unity_MetaVertexControl;
    bool4 unity_MetaFragmentControl;
CBUFFER_END

float unity_OneOverOutputBoost;
float unity_MaxOutputValue;
float unity_UseLinearSpace;

float4 MetaVertexPosition(float3 positionOS, float2 uv1, float4 uv1ST)
{
    positionOS.xy = uv1 * uv1ST.xy + uv1ST.zw;
    positionOS.z = positionOS.z > 0 ? REAL_MIN : 0.0f;
    return TransformWorldToHClip(positionOS.xyz);
}

struct a2v
{
    float3 positionOS       : POSITION;
    float2 uv0              : TEXCOORD0;
    float2 uv1              : TEXCOORD1;
};

struct v2f
{
    half4 positionCS       : SV_POSITION;
    float2 uv0              : TEXCOORD0;
};

v2f vert(a2v i)
{
    v2f o = (v2f)0;
    o.positionCS = MetaVertexPosition(i.positionOS, i.uv1, unity_LightmapST);
    o.uv0 = i.uv0;
    return o;
}

half4 frag(v2f i) : SV_TARGET
{
    float2 UV_1 = i.uv0.xy * _Tiling.x;
    float2 UV_2 = i.uv0.xy * _Tiling.y;
    float2 UV_3 = i.uv0.xy * _Tiling.z;
    float2 UV_4 = i.uv0.xy * _Tiling.w;
    half4 _Diffuse1 = SAMPLE_TEXTURE2D(_Splat1, sampler_Splat1, UV_1);
    half4 _Diffuse2 = SAMPLE_TEXTURE2D(_Splat2, sampler_Splat1, UV_2);
    half4 _Diffuse3 = SAMPLE_TEXTURE2D(_Splat3, sampler_Splat1, UV_3);
    half4 _Diffuse4 = SAMPLE_TEXTURE2D(_Splat4, sampler_Splat1, UV_4);
    half4 weight = SAMPLE_TEXTURE2D(_Control, sampler_Control, i.uv0.xy);

    half4 _MixedDiffuse = weight.r * _Diffuse1 + weight.g * _Diffuse2;
    #ifdef _LAYER3
        _MixedDiffuse += weight.b * _Diffuse3;
    #endif
    #ifdef _LAYER4
        _MixedDiffuse += weight.a * _Diffuse4;
    #endif

    half4 res = half4(_MixedDiffuse.rgb, 1.0);
    unity_OneOverOutputBoost = saturate(unity_OneOverOutputBoost);
    res.rgb = clamp(PositivePow(res.rgb, unity_OneOverOutputBoost), 0, unity_MaxOutputValue);
    return res;
}