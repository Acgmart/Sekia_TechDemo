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
    float2  isInCoverShadow        : TEXCOORD4;
    half3  bakedGI           : TEXCOORD5;
    float3 viewDirWS         : TEXCOORD6;
};

v2f vert(a2v i) 
{
    v2f o = (v2f)0;
    o.normalWS.xyz = TransformObjectToWorldNormal(i.normalOS, false);
    o.normalWS.xyz = normalize(o.normalWS.xyz);
    o.normalWS.w = dot(o.normalWS.xyz, _FakeLightDir.xyz) * 0.4975 + 0.5;

    o.isInCoverShadow.x = 0;
    if (_CharacterAmbientSensorShadowOn)
    {
        float ambientSensorValue = SAMPLE_TEXTURE2D_LOD(_AmbientSensor, 
            sampler_AmbientSensor, _AmbientSensorUVs.xy, 0.0).x;
        o.isInCoverShadow.x = ambientSensorValue > 0.5 ? 1.0 : 0.0;
    }
    o.bakedGI.xyz = 0.0;
    o.vertexColor = i.vertexColor;float3 positionOS = i.positionOS;

    if (_UseClipPlane)
    {
        //如果平面在世界空间 则将世界空间的平面转换到模型空间
        float distanceP = dot(i.positionOS, _ClipPlane.xyz);
        if (distanceP < (_ClipPlane.w - 0.01))
        {
            float distanceQ = _ClipPlane.w - distanceP;
            positionOS = i.positionOS + _ClipPlane.xyz * distanceQ; //顶点射线与平面的交点
            o.vertexColor.w = half(0.0);
        }
    }
    
    o.positionWS = TransformObjectToWorld(positionOS);
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

    //透明裁剪
    bool _IsDiffuseMapAlphaClip = _MainTexAlphaUse == 1.0;
    if (_IsDiffuseMapAlphaClip)
        clip(baseMapValue.a - _MainTexAlphaCutoff);
    float4 lightMapValue = SAMPLE_TEXTURE2D_BIAS(_LightMap, sampler_LightMap, i.uv0.xy, mipmapBias);

    //脸红：程序控制材质参数的表情动画
    bool _IsDiffuseMapAlphaFaceFlush = _MainTexAlphaUse == 3.0;
    float faceBlushIntensity = _FaceBlushStrength * baseMapValue.w;
    float3 faceBlushColor = lerp(baseMapValue.xyz, _FaceBlushColor.xyz, faceBlushIntensity);
    float3 _Albedo = _IsDiffuseMapAlphaFaceFlush ? faceBlushColor : baseMapValue.xyz;

    //自发光遮罩
    bool _IsDiffuseMapAlphaEmissionMask = _MainTexAlphaUse == 2.0;
    bool hasEmission = _IsDiffuseMapAlphaEmissionMask && baseMapValue.a > 0.01;
    float emissionMask = hasEmission ? baseMapValue.a : 0;

    //基于遮罩区域控制颜色系数
    bool isType2 = _UseMaterial2 && lightMapValue.w > 0.8;
    bool isType3 = _UseMaterial3 && lightMapValue.w > 0.8 && lightMapValue.w < 0.6;
    bool isType4 = _UseMaterial4 && lightMapValue.w > 0.8 && lightMapValue.w < 0.6;
    bool isType5 = _UseMaterial5 && lightMapValue.w > 0.8 && lightMapValue.w < 0.6;
    float3 baseColor = _Color1.xyz;
    baseColor = isType2 ? _Color2.xyz : baseColor;
    baseColor = isType3 ? _Color3.xyz : baseColor;
    baseColor = isType4 ? _Color4.xyz : baseColor;
    baseColor = isType5 ? _Color5.xyz : baseColor;
    _Albedo = baseColor * _Albedo;

    //手绘阴影渐变区域
    float _AO = _UseLightMapColorAO ? lightMapValue.y : 0.5;
    _AO = _UseVertexColorAO ? i.vertexColor.x * _AO : _AO;
    bool isAlwaysNoShadow = 0.95 < _AO;
    bool isAlwaysInShadow = _AO < 0.05;
    float _NdotL = i.normalWS.w;
    _AO = (_NdotL + _AO) * 0.5;
    _AO = isAlwaysInShadow ? 1 : _AO;
    _AO = isAlwaysNoShadow ? 0 : _AO;
    
    //调整阴影渐变区域
    bool isInSelfShadow = _LightArea > _AO;
    float _ShadowStrength = (_LightArea - _AO) / _LightArea;
    float customShadowRampWidth = _ShadowRampWidth * max(0.01, i.vertexColor.y * 2);
    float shadowRampWidth = _UseVertexRampWidth ? customShadowRampWidth : _ShadowRampWidth;
    float _NdotL_Ramp = 1 - min(1, _ShadowStrength / shadowRampWidth);
    _NdotL_Ramp = i.isInCoverShadow.x ? 0.0 : isInSelfShadow ? _NdotL_Ramp : 1.0;
    _ShadowStrength = isInSelfShadow ? _ShadowStrength : 0.0;

    bool isInAnyShadow = i.isInCoverShadow.x || isInSelfShadow;
    float _LightIntensity = mhy_AvatarLightDir.w > 0.5 ? min(1, _LightColor0.w * 2) : 1;
    float specularB = max(0.001, dot(i.normalWS.xyz, _HalfDir));
    bool isNight = _LightIntensity < 1.0;
    float3 diffuseTerm = 0.0;
    float3 specularTerm = 0.0;
    float3 emissionTerm = 0.0;
    float3 shadowRamp_Day = 0.0;
    float3 shadowRamp_Night = 0.0;
    bool isMetal = lightMapValue.x > 0.9;

    if (isMetal) 
    {
        //金属物体使用基于视角的漫反射
        float3 _NormalVS = TransformWorldToViewDir(i.normalWS.xyz);
        float2 UV_Mapcap = float2(_NormalVS.x * _MTMapTileScale, _NormalVS.y);
        UV_Mapcap = UV_Mapcap * 0.5 + 0.5;
        float diffuseM = SAMPLE_TEXTURE2D(_MetalMap, sampler_MetalMap, i.uv0.xy).x;
        diffuseM = saturate(diffuseM * _MTMapBrightness);
        float3 diffuseTerm = lerp(_MTMapDarkColor.xyz, _MTMapLightColor.xyz, diffuseM);
        diffuseTerm = diffuseTerm * _Albedo;

        //金属漫反射收到阴影影响
        float3 diffuseTransitionShadowColor = lerp(float3(1.0, 1.0, 1.0), _MTShadowMultiColor.xyz, _ShadowStrength);
        float3 diffuseShadowColor = _UseShadowTransition ? diffuseTransitionShadowColor : _MTShadowMultiColor.xyz;
        float3 diffuseTerm_Shadow = diffuseTerm * diffuseShadowColor;
        float3 diffuseTerm_Lit = diffuseTerm * _ES_CharacterMainLightBrightness;
        diffuseTerm = isInAnyShadow ? diffuseTerm_Shadow : diffuseTerm_Lit;
        
        //金属漫反射受到昼夜影响
        float3 diffuseTerm_Night = lerp(diffuseTerm_Shadow, diffuseTerm, _LightIntensity);
        diffuseTerm = isNight ? diffuseTerm_Night : diffuseTerm;

        //高光只受到遮蔽影影响
        specularB = pow(specularB, _MTShininess);
        specularB = saturate(specularB * _MTSpecularScale);
        specularTerm = specularB * _MTSpecularColor.xyz * lightMapValue.z;
        float3 specularTerm_InShadow = _MTSpecularAttenInShadow * specularTerm;
        specularTerm = i.isInCoverShadow.x ? specularTerm_InShadow : specularTerm;
        specularTerm = specularTerm * _ES_CharacterMainLightBrightness;
    } 
    else 
    {

        uint matTypeCode = isType5 ? 4u : isType4 ? 3u : 
                    isType3 ? 2u : isType2 ? 1u : 0u;
        float rampY1 = 1 - (matTypeCode * 0.1 + 0.05);
        float rampY2 = 1 - (matTypeCode * 0.1 + 0.55);

        if (_UseCoolShadowColorOrTex) 
        {
            float2 UV_ShadowRamp1 = float2(_NdotL_Ramp, rampY1);
            float2 UV_ShadowRamp2 = float2(_NdotL_Ramp, rampY2);
            float3 shadowRampValue1 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp1).xyz;
            float3 shadowRampValue2 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp2).xyz;
            shadowRamp_Day = lerp(shadowRampValue2, shadowRampValue1, _ES_CharacterColorTone);
        } 
        else 
        {
            float2 UV_ShadowRamp1 = float2(_NdotL_Ramp, rampY1);
            shadowRamp_Day = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp1).xyz;
        }

        if (isNight) 
        {
            if (_UseCoolShadowColorOrTex) 
            {
                float2 UV_ShadowRamp3 = float2(0.0, rampY1);
                float2 UV_ShadowRamp4 = float2(0.0, rampY2);
                float3 shadowRampValue3 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp3).xyz;
                float3 shadowRampValue4 = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp4).xyz;
                float3 shadowRamp_Night = lerp(shadowRampValue4, shadowRampValue3, _ES_CharacterColorTone);
            } 
            else 
            {
                float2 UV_ShadowRamp3 = float2(0.0, rampY1);
                float3 shadowRamp_Night = SAMPLE_TEXTURE2D(_ShadowRamp, sampler_ShadowRamp, UV_ShadowRamp3).xyz;
            }
        } 
        
        float3 diffuseTerm_Shadow = shadowRamp_Day * _Albedo;
        float3 diffuseTerm_Lit = _ES_CharacterMainLightBrightness * _Albedo;
        float3 difuseTerm_Day = isInAnyShadow ? diffuseTerm_Shadow : diffuseTerm_Lit;
        float3 difuseTerm_Night = shadowRamp_Night * _Albedo;
        difuseTerm_Night = lerp(difuseTerm_Night, difuseTerm_Day, _LightIntensity);
        diffuseTerm = isNight ? difuseTerm_Night : difuseTerm_Day;

        float shininess = isType5 ? _Shininess5 : isType4 ? _Shininess4 : isType3 ? 
            _Shininess3 : isType2 ? _Shininess2 : _Shininess1;
        float specMul = isType5 ? _SpecMulti5 : isType4 ? _SpecMulti4 : isType3 ? 
            _SpecMulti3 : isType2 ? _SpecMulti2 : _SpecMulti1;
        specularB = pow(specularB, shininess);
        specularTerm = lightMapValue.x * _SpecularColor.xyz * specMul * _ES_CharacterMainLightBrightness;
        bool isInSpecular = specularB > (1 - lightMapValue.z);
        specularTerm = isInSpecular ? specularTerm : float3(0.0, 0.0, 0.0);
    }

    specularTerm = isNight ? (specularTerm * _LightIntensity) : specularTerm;
    float3 _Color = diffuseTerm + specularTerm;

    if (hasEmission)
    {
        float3 emisionBase = _EmissionColor.xyz * _Albedo;
        float emissionCof = isType5 ? _Color5.w : isType4 ? _Color4.w :
            isType3 ? _Color3.w : isType2 ? _Color2.w : _Color1.w;
        emissionTerm = emisionBase * _EmissionScaler * emissionCof;
        _Color += lerp(_Color, emissionTerm, emissionMask);
    } 

    //溶解-边缘光 驱动_DissolveValue
    float frenelPower = saturate((1 - _DissolveValue) * 3.333) * 5;
    float fresnelBase = dot(_ViewDirWS, i.normalWS.xyz);
    fresnelBase = max(0.001, 1.0 - fresnelBase);
    fresnelBase = pow(fresnelBase, frenelPower);
    float3 _FresnelTerm = fresnelBase * _DissolveColor.rgb * _DissolveValue;
    _Color += _FresnelTerm;

    float maxChannel = max(_Color.r, max(_Color.g, _Color.b));
    bool hasBloom = maxChannel > 1.0;
    float bloomMask = hasBloom ? maxChannel : 1.0;
    float3 result = hasBloom ? (_Color / maxChannel) : _Color;
    bloomMask = sqrt(saturate(0.05 * bloomMask));
    return half4(result, bloomMask);
}