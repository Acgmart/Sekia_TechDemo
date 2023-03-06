Shader "Hidden/ScreenSpaceFluidRendering/BilateralFilterBlur"
{
	Properties
	{
		_MainTex ("", 2D) = "black"
	}
	CGINCLUDE

	#include "UnityCG.cginc"

	sampler2D _MainTex;
	float4    _MainTex_TexelSize;

	float  _FilterRadius;     // ブラーエフェクトの半径
	float2 _BlurDir;          // ブラーの方向
	float  _BlurScale;        // ブラーのスケール
	float  _BlurDepthFallOff; // 深度によるブラーの強さの減衰値
	

	// --------------------------------------------------------------------
	// Fragment Shader
	// --------------------------------------------------------------------
	fixed4 frag(v2f_img i) : SV_Target
	{
		float depth = tex2D(_MainTex, i.uv).x;

		if (depth <= 0.0f)
		{
			return 0;
		}

		float sum  = 0.0;
		float wsum = 0.0;

		float2 blurDir = float2
		(
			_MainTex_TexelSize.x * _BlurDir.x,
			_MainTex_TexelSize.y * _BlurDir.y
		);
		[unroll(32)]
		for (float x = -_FilterRadius; x <= _FilterRadius; x += 1.0)
		{
			float sampleDepth = tex2D(_MainTex, i.uv.xy + x * blurDir.xy).x;

			// spatial domain
			float r = x * _BlurScale;
			float w = exp(-r*r); // ガウス関数

			// range domain
			float2 r2 = (sampleDepth - depth) * _BlurDepthFallOff;
			float  g  = exp(-r2*r2); // ガウス関数

			sum  += sampleDepth * w * g;
			wsum += w * g;
		}

		if (wsum > 0.0)
			sum /= wsum;

		return sum;
	}
	ENDCG

	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex   vert_img
			#pragma fragment frag
			ENDCG
		}
	}
}
