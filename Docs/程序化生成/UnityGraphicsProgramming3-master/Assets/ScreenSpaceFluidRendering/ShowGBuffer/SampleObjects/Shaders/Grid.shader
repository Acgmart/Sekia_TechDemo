Shader "Hidden/ScreenSpaceFluidRendering/ShowGBuffer/Grid" {
	Properties {
		_ColorA ("Color A", Color) = (1,1,1,1)
		_ColorB ("Color B", Color) = (0,0,0,0)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _ColorA;
		fixed4 _ColorB;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float2 uv = IN.uv_MainTex.xy;
			o.Albedo = fmod(floor(uv.x * 20.0) + fmod(floor(uv.y * 20.0), 2.0), 2.0) > 0.5 ? _ColorA : _ColorB;
			o.Metallic   = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha      = 1.0;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
