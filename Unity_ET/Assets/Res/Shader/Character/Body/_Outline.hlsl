struct a2v 
{
    float3 positionOS        : POSITION;
    float3 normalOS          : NORMAL;
    float2 uv0               : TEXCOORD0;
    half4  vertexColor       : COLOR;
};

struct v2f 
{
    float4 positionCS        : SV_POSITION;
    float4 uv0               : TEXCOORD0;
};

v2f vert(a2v i) 
{
    v2f o = (v2f)0;
    float3 positionWS = TransformObjectToWorld(i.positionOS);
    float3 positionVS = TransformWorldToView(positionWS);
    float3 normalWS = TransformObjectToWorldNormal(i.normalOS);
    float2 normalVS = TransformWorldToViewDir(normalWS).xy;
    normalVS = normalize(float3(normalVS, 0.01)).xy;

    //法线扩张 基于FOV和距离缩放描边宽度
    float distanceZ = 2.414 / UNITY_MATRIX_P[1].y * (-positionVS.z);
    bool isInNear  = distanceZ < _OutlineWidthAdjustZs.y;
    float distanceStart = isInNear ? _OutlineWidthAdjustZs.x : _OutlineWidthAdjustZs.y;
    float distanceEnd = isInNear ? _OutlineWidthAdjustZs.y : _OutlineWidthAdjustZs.z;
    float scaleStart = isInNear ? _OutlineWidthAdjustScales.x : _OutlineWidthAdjustScales.y;
    float scaleEnd = isInNear ? _OutlineWidthAdjustScales.y : _OutlineWidthAdjustScales.z;
    float linearIntensity = (distanceZ - distanceStart) / max(distanceEnd - distanceStart, 0.001);
    float linearScale = lerp(scaleStart, scaleEnd, linearIntensity);
    float outlineWidth = i.vertexColor.w * _OutlineWidth * linearScale;
    float2 normalExtend = normalVS * outlineWidth;

    //观察空间顶点扩张 增加Z值 少量放大
    float3 viewSpacePositionDir = normalize(positionVS);
    float3 positionExtend = viewSpacePositionDir * _MaxOutlineZOffset;
    positionExtend *= i.vertexColor.z - 0.5;

    positionVS.xy += normalExtend;
    positionVS += positionExtend;
    o.positionCS = mul(GetViewToHClipMatrix(), float4(positionVS, 1.0));
    o.uv0.xy = i.uv0.xy;
    return o;
}

half4 frag(v2f i) : SV_TARGET
{
    float4 lightMapValue = SAMPLE_TEXTURE2D(_LightMap, sampler_LightMap, i.uv0.xy);

    //基于遮罩区域控制颜色系数
    bool isType2 = lightMapValue.w > 0.8;
    bool isType3 = lightMapValue.w > 0.4 && lightMapValue.w < 0.6;
    bool isType4 = lightMapValue.w > 0.2 && lightMapValue.w < 0.4;
    bool isType5 = lightMapValue.w > 0.6 && lightMapValue.w < 0.8;
    float3 outlineColor = _Color1.xyz * _OutlineColor1.xyz;
    outlineColor = isType2 ? _Color2.xyz * _OutlineColor2.xyz : outlineColor;
    outlineColor = isType3 ? _Color3.xyz * _OutlineColor3.xyz : outlineColor;
    outlineColor = isType4 ? _Color4.xyz * _OutlineColor4.xyz : outlineColor;
    outlineColor = isType5 ? _Color5.xyz * _OutlineColor5.xyz : outlineColor;
    return half4(outlineColor, 0.05);
}