Shader "Sekia/Level/Effect/FlagWaving" 
{
	Properties 
	{
		_BaseColor("BaseColor", Color) = (1, 1, 1, 1)
		_BaseMap("BaseMap", 2D) = "white" {}

		_WavingStrength("摇摆强度", Range(-1, 1)) = 0.5
		_WavingSpeed("摇摆速度", Range(0, 10)) = 1
		_WavingTiling("波浪Tiling", Float) = 5
		_WavingDir("摇摆方向", Range(0, 1)) = 0
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
				float	_WavingStrength;
				float	_WavingSpeed;
				float	_WavingTiling;
				float	_WavingDir;
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
			};

			v2f vert (a2v i) 
			{
				v2f o = (v2f)0;
				float3 normalWS = TransformObjectToWorldNormal(i.normalOS);

				float distance = 1.0 - i.uv0.y; //横向距离
    			float horizontalCof = min(PositivePow(distance, 0.3), 1.0);
    			horizontalCof = distance < 0.1 ? distance : horizontalCof;
				float3 moveDir =  horizontalCof * i.normalOS * _WavingStrength;

				float noiseCof = _WavingDir * 3.1415925; //基于横向和纵混合噪音
				float noiseBase = i.uv0.x * cos(noiseCof) + distance * sin(noiseCof);
				float noiseValue = sin(noiseBase * _WavingTiling - _Time.y * _WavingSpeed);
				float3 positionOffset = moveDir * noiseValue;

				o.postionCS = TransformObjectToHClip(i.positionOS + positionOffset);
				o.uv0.xy = i.uv0;
				return o;
			}

			half4 frag(v2f i) : SV_TARGET
			{
				half4 baseMapValue = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv0.xy);
				baseMapValue *= _BaseColor;
                return baseMapValue;
			}
		ENDHLSL
		}
	}
}
