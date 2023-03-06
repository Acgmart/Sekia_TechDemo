Shader "Custom/Reaction Diffusion 2D Standard" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_NormalTex("Normal Tex", 2D) = "bump" {}
		[Space]
		_Color0("Bottom Color", Color) = (1,1,1,1)
		_Color1("Top Color", Color) = (1,1,1,1)
		[Space]
		_Emit0("EmitColor 0", Color) = (1,1,1,1)
		_Emit1("EmitColor 1", Color) = (1,1,1,1)
		_EmitInt0("Emit Intensity 0", Range(0, 1)) = 0
		_EmitInt1("Emit Intensity 1", Range(0, 1)) = 0
		[Space]
		_Smoothness0("Smoothness 0", Range(0, 1)) = 0.5
		_Smoothness1("Smoothness 1", Range(0, 1)) = 0.5
		[Space]
		_Metallic0("Metallic 0", Range(0, 1)) = 0.0
		_Metallic1("Metallic 1", Range(0, 1)) = 0.0
		[Space]
		_Threshold("Threshold", Range(0, 1)) = 0.1
		_Fading("Edge Smoothing", Range(0, 1)) = 0.2
		_NormalStrength("Normal Strength", Range(0, 1)) = 0.9
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }

			CGPROGRAM
			#pragma surface surf Standard addshadow

			sampler2D _MainTex;
			float4 _MainTex_TexelSize;
			sampler2D _NormalTex;
			float4 _NormalTex_TexelSize;

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct Input {
				float2 uv_MainTex;
			};

			fixed4 _Color0, _Color1;
			fixed4 _Emit0, _Emit1;
			half _Smoothness0, _Smoothness1;
			half _Metallic0, _Metallic1;
			half _Threshold, _Fading;
			half _NormalStrength;
			half _EmitInt0, _EmitInt1;

			void surf(Input IN, inout SurfaceOutputStandard o) {

				float2 uv = IN.uv_MainTex;

				// 濃度取得
				half v0 = tex2D(_MainTex, uv).x;

				// 法線取得
				float3 norm = UnpackNormal(tex2D(_NormalTex, uv));

				// AとBの境界の値を出す
				half p = smoothstep(_Threshold, _Threshold + _Fading, v0);

				o.Albedo = lerp(_Color0.rgb, _Color1.rgb, p);		// ベース色
				o.Alpha = lerp(_Color0.a, _Color1.a, p);			// アルファ値
				o.Smoothness = lerp(_Smoothness0, _Smoothness1, p);	// スムースネス
				o.Metallic = lerp(_Metallic0, _Metallic1, p);		// メタリック
				o.Normal = normalize(float3(norm.x, norm.y, 1 - _NormalStrength));	// 法線
				o.Occlusion = 1;
				o.Emission = lerp(_Emit0 * _EmitInt0, _Emit1 * _EmitInt1, p).rgb;	// 発光
			}
			ENDCG
		}
			FallBack "Diffuse"
}
