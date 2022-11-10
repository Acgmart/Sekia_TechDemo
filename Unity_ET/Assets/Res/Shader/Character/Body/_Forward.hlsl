struct a2v 
{
    float3 positionOS        : POSITION;
    float3 normalOS          : NORMAL;
    float2 uv0               : TEXCOORD0;
    float2 uv1               : TEXCOORD1;
    half4  vertexColor       : COLOR;
};

struct v2f 
{
    float4 positionCS        : SV_POSITION;
    half4  vertexColor       : COLOR;
    float4 uv0               : TEXCOORD0;
    float4 normalWS          : TEXCOORD1;
    float4 screenUV          : TEXCOORD2;
    float3 positionWS        : TEXCOORD3;
    float3 viewDirWS         : TEXCOORD6;
};

v2f vert(a2v i) 
{
    v2f o = (v2f)0;
    o.normalWS.xyz = TransformObjectToWorldNormal(i.normalOS, false);
    o.normalWS.xyz = normalize(o.normalWS.xyz);
    o.normalWS.w = dot(o.normalWS.xyz, _FakeLightDir.xyz) * 0.4975 + 0.5;
    o.vertexColor = i.vertexColor;
    o.positionWS = TransformObjectToWorld(i.positionOS);
    o.viewDirWS = normalize(_WorldSpaceCameraPos.xyz - o.positionWS);
    o.positionCS = TransformWorldToHClip(o.positionWS);
    o.uv0.xy = i.uv0.xy;
    o.uv0.zw = i.uv1.xy;
    o.screenUV = ComputeScreenPos(o.positionCS);
    return o;
}

half4 frag(v2f i) : SV_TARGET
{
    float3 _ViewDirWS = normalize(_WorldSpaceCameraPos.xyz - i.positionWS.xyz);
    float3 _HalfDir = normalize(_ViewDirWS + _FakeLightDir.xyz);

    //BaseMap Dither效果触发时有mip等级变化
    float mipmapBias = _TextureBiasWhenDithering - 1;
    float4 baseMapValue = SAMPLE_TEXTURE2D_BIAS(_BaseMap, sampler_BaseMap, i.uv0.xy, mipmapBias);
    float3 _Albedo = baseMapValue.xyz;

    float4 lightMapValue = SAMPLE_TEXTURE2D_BIAS(_LightMap, sampler_LightMap, i.uv0.xy, mipmapBias);;
    float emissionMask = baseMapValue.a;

    //基于遮罩区域控制颜色系数
    bool isType2 = lightMapValue.w > 0.8;
    bool isType3 = lightMapValue.w > 0.4 && lightMapValue.w < 0.6;
    bool isType4 = lightMapValue.w > 0.2 && lightMapValue.w < 0.4;
    bool isType5 = lightMapValue.w > 0.6 && lightMapValue.w < 0.8;
    float3 baseColor = _Color1.xyz;
    baseColor = isType2 ? _Color2.xyz : baseColor;
    baseColor = isType3 ? _Color3.xyz : baseColor;
    baseColor = isType4 ? _Color4.xyz : baseColor;
    baseColor = isType5 ? _Color5.xyz : baseColor;
    _Albedo = baseColor * _Albedo;

    //手绘阴影渐变区域
    float _AO = lightMapValue.y * i.vertexColor.x;
    bool isAlwaysNoShadow = 0.95 < _AO;
    bool isAlwaysInShadow = _AO < 0.05;
    float _NdotL = i.normalWS.w;
    _AO = (_NdotL + _AO) * 0.5;
    _AO = isAlwaysNoShadow ? 1 : _AO;
    _AO = isAlwaysInShadow ? 0 : _AO;
    
    //调整阴影渐变区域
    bool isInSelfShadow = _LightArea > _AO;
    float _ShadowStrength = (_LightArea - _AO) / _LightArea;
    float customShadowRampWidth = _ShadowRampWidth * max(0.01, i.vertexColor.y * 2);
    float shadowRampWidth = customShadowRampWidth;
    float _NdotL_Ramp = 1 - min(1, _ShadowStrength / shadowRampWidth);
    _NdotL_Ramp = isInSelfShadow ? _NdotL_Ramp : 1.0;
    _ShadowStrength = isInSelfShadow ? _ShadowStrength : 0.0;

    bool isInAnyShadow = _IsInCoverShader || isInSelfShadow;
    float specularB = max(0.001, dot(i.normalWS.xyz, _HalfDir));
    bool isNight = _IsInNight;
    float3 diffuseTerm = 0.0;
    float3 specularTerm = 0.0;
    float3 emissionTerm = 0.0;
    float3 shadowRamp_Day = 0.0;
    float3 shadowRamp_Night = 0.0;
    bool isMetal = lightMapValue.x > 0.9;

    float3 _TestValue = 0;
    if (isMetal) 
    {
        //金属物体使用基于视角的漫反射
        float3 _NormalVS = TransformWorldToViewDir(i.normalWS.xyz);
        float2 UV_Mapcap = float2(_NormalVS.x * _MTMapTileScale, _NormalVS.y);
        UV_Mapcap = UV_Mapcap * 0.5 + 0.5;
        float diffuseM = SAMPLE_TEXTURE2D(_MetalMap, sampler_MetalMap, UV_Mapcap).x;
        diffuseM = saturate(diffuseM * _MTMapBrightness);
        diffuseTerm = lerp(_MTMapDarkColor.xyz, _MTMapLightColor.xyz, diffuseM);
        diffuseTerm = diffuseTerm * _Albedo;

        //金属漫反射收到阴影影响
        float3 diffuseTerm_Shadow = diffuseTerm * _MTShadowMultiColor.xyz;
        float3 diffuseTerm_Lit = diffuseTerm * _DirectLightingCof;
        diffuseTerm = isInAnyShadow ? diffuseTerm_Shadow : diffuseTerm_Lit;
        
        //金属漫反射受到昼夜影响
        float3 diffuseTerm_Night = lerp(diffuseTerm_Shadow, diffuseTerm, _NightIntensity);
        diffuseTerm = isNight ? diffuseTerm_Night : diffuseTerm;

        //高光只受到遮蔽影影响
        specularB = pow(specularB, _MTShininess);
        specularB = saturate(specularB * _MTSpecularScale);
        specularTerm = specularB * _MTSpecularColor.xyz * lightMapValue.z;
        float3 specularTerm_Shadow = specularTerm * _MTSpecularAttenInShadow;
        specularTerm = _IsInCoverShader ? specularTerm_Shadow : specularTerm;
        specularTerm = specularTerm * _DirectLightingCof;
    } 
    else 
    {
        uint matTypeCode = isType5 ? 4u : isType4 ? 3u : 
                    isType3 ? 2u : isType2 ? 1u : 0u;
        float rampY1 = 1 - (matTypeCode * 0.1 + 0.05);
        float rampY2 = 1 - (matTypeCode * 0.1 + 0.55);
        float2 UV_ShadowRamp1 = float2(_NdotL_Ramp, rampY1);
        float2 UV_ShadowRamp2 = float2(_NdotL_Ramp, rampY2);
        float3 shadowRampValue1 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp1).xyz;
        float3 shadowRampValue2 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp2).xyz;
        shadowRamp_Day = lerp(shadowRampValue2, shadowRampValue1, _WarmCoolCof);

        if (isNight) 
        {
            float2 UV_ShadowRamp3 = float2(0.0, rampY1);
            float2 UV_ShadowRamp4 = float2(0.0, rampY2);
            float3 shadowRampValue3 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp3).xyz;
            float3 shadowRampValue4 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp4).xyz;
            shadowRamp_Night = lerp(shadowRampValue4, shadowRampValue3, _WarmCoolCof);
        } 
        
        float3 diffuseTerm_Shadow = shadowRamp_Day * _Albedo;
        float3 diffuseTerm_Lit = _DirectLightingCof * _Albedo;
        float3 difuseTerm_Day = isInAnyShadow ? diffuseTerm_Shadow : diffuseTerm_Lit;
        float3 difuseTerm_Night = shadowRamp_Night * _Albedo;
        difuseTerm_Night = lerp(difuseTerm_Night, difuseTerm_Day, _NightIntensity);
        diffuseTerm = isNight ? difuseTerm_Night : difuseTerm_Day;

        float shininess = isType5 ? _Shininess5 : isType4 ? _Shininess4 : isType3 ? 
            _Shininess3 : isType2 ? _Shininess2 : _Shininess1;
        float specMul = isType5 ? _SpecMulti5 : isType4 ? _SpecMulti4 : isType3 ? 
            _SpecMulti3 : isType2 ? _SpecMulti2 : _SpecMulti1;
        specularB = pow(specularB, shininess);
        specularTerm = lightMapValue.x * _SpecularColor.xyz * specMul * _DirectLightingCof;
        bool isInSpecular = specularB > (1 - lightMapValue.z);
        specularTerm = isInSpecular ? specularTerm : float3(0.0, 0.0, 0.0);
    }

    specularTerm = isNight ? (specularTerm * _NightIntensity) : specularTerm;
    float3 _Color = diffuseTerm + specularTerm;

    float3 emisionBase = _EmissionColor.xyz * _Albedo;
    float emissionCof = isType5 ? _Color5.w : isType4 ? _Color4.w :
    isType3 ? _Color3.w : isType2 ? _Color2.w : _Color1.w;
    emissionTerm = emisionBase * _EmissionScaler * emissionCof;
    _Color += lerp(_Color, emissionTerm, emissionMask);
    
    float maxChannel = max(_Color.r, max(_Color.g, _Color.b));
    bool hasBloom = maxChannel > 1.0;
    float bloomMask = hasBloom ? maxChannel : 1.0;
    float3 result = hasBloom ? (_Color / maxChannel) : _Color;
    bloomMask = sqrt(saturate(0.05 * bloomMask));
    
    //result = isInAnyShadow;
    return half4(result, bloomMask);
}