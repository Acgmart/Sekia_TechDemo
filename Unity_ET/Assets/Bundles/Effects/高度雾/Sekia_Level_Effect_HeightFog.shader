Shader "Sekia/Level/Effect/HeightFog" 
{
	Properties 
	{
		_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
		_BaseMap("BaseMap", 2D) = "white" {}

		_HeigtFogParams("_HeigtFogParams", Vector) = (1, 1, 0.5, 0.5)
		_HeigtFogRamp("_HeigtFogRamp", Vector) = (0.5, 0.5, 0.5, 0.5)
		_HeigtFogColParams("_HeigtFogColParams", Vector) = (0.5, 0.5, 0.5, 0.5)
		_HeigtFogParams2("_HeigtFogParams2", Vector) = (0.5, 0.5, 0.5, 0.5)

		_HeigtFogTopColor("高处颜色", Color) = (0.5, 0.5, 0.5, 0.5)
		_HeigtFogButtomColor("低处颜色", Color) = (0.5, 0.5, 0.5, 0.5)
		_HeigtFogRadialCol("径向颜色", Color) = (0.5, 0.5, 0.5, 0.5)
		_HeigtFogColDelta("_HeigtFogColDelta", Color) = (0.5, 0.5, 0.5, 0.5)
		_HeigtFogColBase("_HeigtFogColBase", Color) = (0.5, 0.5, 0.5, 0)
	}

	SubShader 
	{
        Tags { "RenderPipeline"="UniversalPipeline" "Queue"="Transparent" }

		Pass
		{
		    Name "FORWARD"
            Tags { "LightMode"="UniversalForward" }
			Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
			Cull Off

			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

			CBUFFER_START(UnityPerMaterial)
				half4	_BaseColor;
		
				float4 _HeigtFogParams;
				float4 _HeigtFogRamp;
				float4 _HeigtFogColParams;
				float4 _HeigtFogParams2;

				float4 _HeigtFogTopColor;
				half4  _HeigtFogButtomColor;
				float4 _HeigtFogRadialCol;
				float4 _HeigtFogColBase;
				float4 _HeigtFogColDelta;
			CBUFFER_END

			TEXTURE2D(_BaseMap); SAMPLER(sampler_BaseMap);

			struct a2v
			{
    			float3 positionOS 		: POSITION;
				float3 normalOS 		: NORMAL;
				float2 uv0 				: TEXCOORD0;
			};

			struct v2f 
			{
				float4 postionCS 		: SV_POSITION;
				float4 uv0 				: TEXCOORD0;
				half4 heightFogCof		: TEXCOORD1;
				half4 test				: TEXCOORD2;
			};


			v2f vert (a2v i) 
			{
				v2f o = (v2f)0;
				float3 positionWS = TransformObjectToWorld(i.positionOS);
				o.postionCS = TransformWorldToHClip(positionWS);
				o.uv0.xy = i.uv0;

				float3 viewVector = positionWS - _WorldSpaceCameraPos.xyz;
				float viewDistance = length(viewVector);

				//雾浓度
				float value1 = viewVector.y * _HeigtFogParams.x;
    			float value2 = (1.0 - exp(-value1)) / value1; 		//越低的地方雾浓度越高
    			float value3 = abs(value1) > 0.01 ? value2 : 1.0;	//避免分母为0
				value3 = 1.0 - exp2(-viewDistance * _HeigtFogParams.y * value3); //随着深度雾浓度变高
				value3 = max(value3, 0.0);
				float value4 = viewVector.y * _HeigtFogParams2.x;
    			float value5 = (1.0 - exp(-value4)) / value4;
				float value6 = abs(value4) > 0.01 ? value5 : 1.0;
    			value6 = 1.0 - exp2(-viewDistance * _HeigtFogParams2.y * value6);
				value6 = max(value6, 0.0);
				float value7 = value3 + value6;

				float value8 = saturate(viewDistance * _HeigtFogRamp.x + _HeigtFogRamp.y);
				value8 = value8 * (2.0 - value8);
				value8 = value8 * _HeigtFogRamp.z - _HeigtFogRamp.z + 1.0; //随着观察距离雾浓度变高

				float fogAlpha = min(value8 * value7, _HeigtFogColBase.w);
    			float value10 = 1.0 - fogAlpha;

				float value12 = saturate(positionWS.y * _HeigtFogParams2.w + _HeigtFogParams2.z);
				float3 color1 = value12 * _HeigtFogTopColor.xyz + _HeigtFogButtomColor.xyz; //雾颜色1
				float value11 = saturate(positionWS.y * _HeigtFogColParams.x + _HeigtFogColParams.y);
    			value11 = value11 * (2.0 - value11);
				float3 color2 =  value11 * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
				float value13 = saturate((viewDistance - _HeigtFogRamp.w) * _HeigtFogColParams.w);
				color2 = lerp(color2, _HeigtFogRadialCol.xyz, value13); //雾颜色2

				float value14 = saturate(viewDistance * _HeigtFogParams.z + _HeigtFogParams.w);
    			value14 = value14 * (2.0 - value14);
    			float viewZ = TransformWorldToViewDir(viewVector, false).z;
    			value14 = -viewZ > (_ProjectionParams.z * 0.999) ? (value14 * _HeigtFogColDelta.w) : value14;
				value14 = PositivePow(value14, _HeigtFogButtomColor.w);
    			value14 = min(value14, _HeigtFogColBase.w);
				float value15 = 1.0 - value14;

				//雾1混合雾2得到雾颜色 然后混合底色
    			o.heightFogCof.w = value10 * value15;
    			o.heightFogCof.xyz = color1 * fogAlpha + value10 * value14 * color2;
				return o;
			}

			half4 frag(v2f i) : SV_TARGET
			{
				half4 baseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv0.xy);
				baseMapValue *= _BaseColor;
				baseMapValue.xyz *= saturate(i.heightFogCof.w);
				baseMapValue.xyz += i.heightFogCof.xyz;
                return baseMapValue;
			}
		ENDHLSL
		}
	}
}
