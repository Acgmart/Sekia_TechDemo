Shader "Hidden/ScreenSpaceFluidRendering/ShowGBuffer"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[KeywordEnum(DIFFUSE, SPECULAR, WORLDNORMAL, EMISSION, DEPTH, SOURCE)]
		_GBufferType ("G-Buffer Type", Float) = 0
	}
	CGINCLUDE
	#include "UnityCG.cginc"

	
	
	sampler2D _MainTex;
	
	sampler2D _CameraGBufferTexture0;
	sampler2D _CameraGBufferTexture1;
	sampler2D _CameraGBufferTexture2;
	sampler2D _CameraGBufferTexture3;
	sampler2D _CameraDepthTexture;
	

	fixed4 frag(v2f_img i) : SV_Target
	{		
		#ifdef _GBUFFERTYPE_DIFFUSE
			fixed4 col = tex2D(_CameraGBufferTexture0, i.uv);
		#elif  _GBUFFERTYPE_SPECULAR
			fixed4 col = tex2D(_CameraGBufferTexture1, i.uv);
		#elif  _GBUFFERTYPE_WORLDNORMAL
			fixed4 col = tex2D(_CameraGBufferTexture2, i.uv);
		#elif  _GBUFFERTYPE_EMISSION
			fixed4 col = tex2D(_CameraGBufferTexture3, i.uv);
		#elif  _GBUFFERTYPE_DEPTH
			fixed4 col = Linear01Depth(tex2D(_CameraDepthTexture, i.uv));
		#else
			fixed4 col = tex2D(_MainTex, i.uv);
		#endif
		return fixed4(col.rgb * col.a, 1.0);
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
			#pragma shader_feature _GBUFFERTYPE_DIFFUSE _GBUFFERTYPE_SPECULAR _GBUFFERTYPE_WORLDNORMAL _GBUFFERTYPE_EMISSION _GBUFFERTYPE_DEPTH _GBUFFERTYPE_SOURCE
			ENDCG
		}
	}
}
