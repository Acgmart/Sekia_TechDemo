CBUFFER_START(UnityPerMaterial)
half4   _BaseColor;
half4   _BaseColor2;
half4   _BaseColor3;
half4   _BaseColor4;
CBUFFER_END

TEXTURE2D(_BaseMap);        SAMPLER(sampler_BaseMap);
TEXTURE2D(_BaseMap2);        SAMPLER(sampler_BaseMap2);
TEXTURE2D(_BaseMap3);        SAMPLER(sampler_BaseMap3);
TEXTURE2D(_BaseMap4);        SAMPLER(sampler_BaseMap4);

struct a2v
{
	float3 positionOS 					: POSITION;
	float2 uv0 							: TEXCOORD0;
};

struct v2f
{
	float4 clipPos 						: SV_POSITION;
	half4 uv0 							: TEXCOORD0;
	float4 uv1 							: TEXCOORD1;
};

v2f vert ( a2v i )
{
	v2f o = (v2f)0;
	float3 positionWS = TransformObjectToWorld(i.positionOS);
	float4 positionCS = TransformWorldToHClip(positionWS);
	o.uv0.xy = i.uv0.xy;
	o.uv1.xy = i.uv0.xy;
	o.clipPos = positionCS;
	return o;
}

half4 frag_Sample0 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample0_1 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample0_2 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	_Color *= _BaseColor2.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample0_3 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	_Color *= _BaseColor2.rgb;
	_Color *= _BaseColor3.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample0_4 ( v2f i  ) : SV_Target
{
	half3 _Color = half3(0.5, 0.0, 0.0);
	_Color *= _BaseColor.rgb;
	_Color *= _BaseColor2.rgb;
	_Color *= _BaseColor3.rgb;
	_Color *= _BaseColor4.rgb;
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample1 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = i.uv0.x;
	return half4(_Color, _Alpha);
}

half4 frag_Sample2 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	_BaseMapValue *= SAMPLE_TEXTURE2D(_BaseMap2, sampler_BaseMap2, UV_0 * 0.9);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample2_1 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 value1 = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	half4 value2 = SAMPLE_TEXTURE2D(_BaseMap2, sampler_BaseMap2, UV_0 * 0.9);
	half4 value3 = SAMPLE_TEXTURE2D(_BaseMap3, sampler_BaseMap3, UV_0 * 0.8);
	half4 _BaseMapValue = value1 * value2 * value3;
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample2_2 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 value1 = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	half4 value2 = SAMPLE_TEXTURE2D(_BaseMap2, sampler_BaseMap2, UV_0 * 0.9);
	half4 value3 = SAMPLE_TEXTURE2D(_BaseMap3, sampler_BaseMap3, UV_0 * 0.8);
	half4 value4 = SAMPLE_TEXTURE2D(_BaseMap4, sampler_BaseMap4, UV_0 * 0.7);
	half4 _BaseMapValue = value1 * value2 * value3 * value4;
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample3 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.1;
	_BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap2, sampler_BaseMap2, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample3_1 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.1;
	_BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap2, sampler_BaseMap2, UV_0);
	UV_0 += _BaseMapValue.r * 0.1;
	_BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap3, sampler_BaseMap3, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}

half4 frag_Sample3_2 ( v2f i  ) : SV_Target
{
	float2 UV_0 = i.uv1.xy;
	half4 _BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, UV_0);
	UV_0 += _BaseMapValue.r * 0.1;
	_BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap2, sampler_BaseMap2, UV_0);
	UV_0 += _BaseMapValue.r * 0.1;
	_BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap3, sampler_BaseMap3, UV_0);
	UV_0 += _BaseMapValue.r * 0.1;
	_BaseMapValue = SAMPLE_TEXTURE2D(_BaseMap4, sampler_BaseMap4, UV_0);
	half3 _Color = _BaseMapValue.rgb; 
	half _Alpha = _BaseMapValue.a;
	return half4(_Color, _Alpha);
}