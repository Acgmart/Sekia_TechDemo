struct a2v
{
   	float3 positionOS   : POSITION;
    float3 normalOS     : NORMAL;
    float4 tangentOS    : TANGENT;
    float2 uv0     		: TEXCOORD0;
    float2 uv1   		: TEXCOORD1;
};

struct v2f
{
    float4 positionCS               : SV_POSITION;
    float3 positionWS               : TEXCOORD0;
    float4 uv0						: TEXCOORD1;
    half3 normalWS                  : TEXCOORD2;
    half4 tangentWS                 : TEXCOORD3;
	half4 viewDirWS					: TEXCOORD4; //w: fogFactor
};

v2f vert(a2v i)
{
    v2f o = (v2f)0;
	o.positionWS.xyz = TransformObjectToWorld(i.positionOS);
    o.positionCS = TransformWorldToHClip(o.positionWS.xyz);
	o.uv0.xy = i.uv0;
    o.uv0.zw = i.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    o.normalWS = TransformObjectToWorldNormal(i.normalOS);
    half sign = i.tangentOS.w * GetOddNegativeScale();
    half3 tangentWS = TransformObjectToWorldDir(i.tangentOS.xyz);
    o.tangentWS = half4(tangentWS, sign);
	o.viewDirWS.xyz = normalize(_WorldSpaceCameraPos.xyz - o.positionWS.xyz);
	o.viewDirWS.w = ComputeFogFactor(o.positionCS.z);
    return o;
}

half4 frag(v2f i) : SV_Target
{
    float2 UV_0 = i.uv0.xy;
	float2 UV_1 = UV_0 * _Tiling.x;
	float2 UV_2 = UV_0 * _Tiling.y;
	float2 UV_3 = UV_0 * _Tiling.z;
	float2 UV_4 = UV_0 * _Tiling.w;
    half4 diffuse1 = SAMPLE_TEXTURE2D(_Splat1, sampler_Splat1, UV_1);
	half4 diffuse2 = SAMPLE_TEXTURE2D(_Splat2, sampler_Splat1, UV_2);
	half4 diffuse3 = SAMPLE_TEXTURE2D(_Splat3, sampler_Splat1, UV_3);
	half4 diffuse4 = SAMPLE_TEXTURE2D(_Splat4, sampler_Splat1, UV_4);
    half3 normal1 = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap1, sampler_NormalMap1, UV_1));
	half3 normal2 = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap2, sampler_NormalMap1, UV_2));
	half3 normal3 = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap3, sampler_NormalMap1, UV_3));
	half3 normal4 = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap4, sampler_NormalMap1, UV_4));

	half4 weight = SAMPLE_TEXTURE2D(_Control, sampler_Control, UV_0);
	half4 smoothness = _SmoothnessCof * half4(diffuse1.a, diffuse2.a, diffuse3.a, diffuse4.a);
	half mixedSmoothness = weight.r * smoothness.r + weight.g * smoothness.g;
	half3 _Diffuse = weight.r * diffuse1.rgb + weight.g * diffuse2.rgb;
	half3 normalTS = weight.r * normal1 + weight.g * normal2;
	#ifdef _LAYER3
		mixedSmoothness += weight.b * smoothness.b;
		_Diffuse += weight.b * diffuse3.rgb;
		normalTS += weight.b * normal3;
    #endif
	#ifdef _LAYER4
		mixedSmoothness += weight.a * smoothness.a;
		_Diffuse += weight.a * diffuse4.rgb;
		normalTS += weight.a * normal4;
    #endif

	half renormFactor = rcp(length(i.normalWS));
    half3 bitangentWS = cross(i.normalWS, i.tangentWS.xyz) * i.tangentWS.w;
    half3 tangentWS = i.tangentWS.xyz * renormFactor;
    half3 normalWS = i.normalWS * renormFactor;
    bitangentWS *= renormFactor;
    half3x3 tangentToWorld = half3x3(tangentWS, bitangentWS, normalWS);
    half3 _NormalWS = mul(normalTS, tangentToWorld);
    half3 _ViewDirWS = i.viewDirWS.xyz;

    #ifdef LIGHTMAP_ON
        half3 _BakedGI = SampleLightmap(i.uv1, normalWS);
    #else
        half3 _BakedGI = 0.5;
    #endif

	half _PerceptualRoughness = half(1.0) - mixedSmoothness;
    half3 _ReflectVector = reflect(-_ViewDirWS, _NormalWS);
    half _NdotV = saturate(dot(_NormalWS, _ViewDirWS));
    half3 _F0 = half3(0.04, 0.04, 0.04);

    half3 _EnvirDiffuse = _BakedGI * _Diffuse;
    half3 envirSpecular1 = EnvironmentReflection(_ReflectVector, _PerceptualRoughness);
    half3 envirSpecular2 = EnvBRDFApprox(_F0, _PerceptualRoughness, _NdotV);
    half3 _EnvirSpecular = envirSpecular1 * envirSpecular2;
    half3 _EnvirLighting = _EnvirDiffuse + _EnvirSpecular;

    //实时光照
    half3 _DirectLighting = AllDirectLighting(i.positionWS.xyz, _NdotV, _NormalWS, _ViewDirWS,
        _Diffuse, _F0, _PerceptualRoughness, envirSpecular2);
    half3 _Color = _EnvirLighting + _DirectLighting;
	half _FogFactor = i.viewDirWS.w;
    _Color = MixFog(_Color, _FogFactor);
    _Color = ACESToneMapping(_Color);
    return half4(_Color, 1.0);
}