Shader "Custom/ReactionDiffusion3D" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		[Space]
		_Color0("Color 0", Color) = (1,1,1,1)
		_Color1("Color 1", Color) = (1,1,1,1)
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
		[Space]
		_Tess("Tessellation", Range(1,32)) = 4
		_Displacement("Displacement", Range(0, 1.0)) = 0.3
		_DispTex("Disp Texture", 2D) = "gray" {}
		_Phong("Phong Strengh", Range(0,1)) = 0.5
		_EdgeLength("Edge length", Range(2,50)) = 5
	}
	SubShader {
		//Tags { "RenderType"="Opaque" }
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows vertex:disp tessellate:tessDistance 
		//#pragma surface surf Standard vertex:dispNone tessellate:tessEdge tessphong:_Phong nolightmap
		//#pragma surface surf Standard fullforwardshadows vertex:disp tessellate:tessEdge
		#pragma surface surf Standard addshadow vertex:disp tessellate:tessDistance tessphong:_Phong alpha:blend

		//#pragma target 3.0
		#pragma target 4.6
		#include "Tessellation.cginc"

		sampler2D _MainTex;
		float4 _MainTex_TexelSize;

		struct appdata {
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
		};

		struct Input {
			float2 uv_MainTex;
			//float4 screenPos;
			//float3 worldPos;
		};

		fixed4 _Color0, _Color1;
		fixed4 _Emit0, _Emit1;
		half _Smoothness0, _Smoothness1;
		half _Metallic0, _Metallic1;
		half _Threshold, _Fading;
		half _NormalStrength;
		half _EmitInt0, _EmitInt1;

		sampler2D _DispTex;
		float _Displacement;
		float _Phong;
		float _EdgeLength;

		float _Tess;

		float4 tessDistance(appdata v0, appdata v1, appdata v2) {
			float minDist = 0.01;
			float maxDist = 5.0;
			return UnityDistanceBasedTess(v0.vertex, v1.vertex, v2.vertex, minDist, maxDist, _Tess);
		}

		float4 tessEdge(appdata v0, appdata v1, appdata v2)
		{
			return UnityEdgeLengthBasedTess(v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void dispNone(inout appdata v) { }

		void disp(inout appdata v)
		{
			float d = tex2Dlod(_DispTex, float4(v.texcoord.xy, 0, 0)).r * _Displacement;
			v.vertex.xyz += v.normal * d;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float3 duv = float3(_MainTex_TexelSize.xy, 0);

			//float2 uv = IN.worldPos.xy * 0.25;
			//float2 uv = IN.screenPos.xy / IN.screenPos.w;
			float2 uv = IN.uv_MainTex;

			half v0 = tex2D(_MainTex, uv).y;
			half v1 = tex2D(_MainTex, uv - duv.xz).y;
			half v2 = tex2D(_MainTex, uv + duv.xz).y;
			half v3 = tex2D(_MainTex, uv - duv.zy).y;
			half v4 = tex2D(_MainTex, uv + duv.zy).y;

			half p = smoothstep(_Threshold, _Threshold + _Fading, v0);

			o.Albedo = lerp(_Color0.rgb, _Color1.rgb, p);
			o.Alpha = lerp(_Color0.a, _Color1.a, p);
			o.Smoothness = lerp(_Smoothness0, _Smoothness1, p);
			o.Metallic = lerp(_Metallic0, _Metallic1, p);
			o.Normal = normalize(float3(v1 - v2, v3 - v4, 1 - _NormalStrength));
			o.Emission = lerp(_Emit0 * _EmitInt0, _Emit1 * _EmitInt1, p).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
