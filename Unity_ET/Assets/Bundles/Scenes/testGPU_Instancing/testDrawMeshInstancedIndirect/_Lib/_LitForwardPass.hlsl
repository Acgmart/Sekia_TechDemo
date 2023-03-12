
struct a2v
{
    float3 positionOS               : POSITION;
    uint unity_InstanceID           : SV_InstanceID;
};

struct v2f
{
    float4 positionCS               : SV_POSITION;
};

v2f vert(a2v i)
{
    v2f o = (v2f)0;
    float4x4 object2world = ComputeObjectToWorldTransform(i.unity_InstanceID);
    float3 positionWS = mul(object2world, float4(i.positionOS, 1.0)).xyz;
    o.positionCS = TransformWorldToHClip(positionWS);
    return o;
}

half4 frag(v2f i) : SV_TARGET
{
    return half4(1.0, 0.0, 0.0, 1.0);
}
