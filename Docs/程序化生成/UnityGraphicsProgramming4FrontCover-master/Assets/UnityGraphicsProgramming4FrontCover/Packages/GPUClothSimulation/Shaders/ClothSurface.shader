Shader "Hidden/GPUClothSimulation/ClothSurface"
{
    Properties
    {
        _Color0 ("Color0",        Color) = (1,1,1,1)
		_Color1 ("Color1",        Color) = (1,1,1,1)
		_Color2 ("Color2",        Color) = (1,1,1,1)
		_Color3 ("Color3",        Color) = (1,1,1,1)
		
		_MainTex    ("Albedo (RGB)", 2D        ) = "white" {}
        _Glossiness ("Smoothness",   Range(0,1)) = 0.5
        _Metallic   ("Metallic",     Range(0,1)) = 0.0

		_PositionTex ("Position Tex", 2D) = "black" {}
		_NormalTex   ("Normal Tex",   2D) = "gray"  {}

		_SpecPower("Specular Power", Range(0, 100)) = 1

		_SpecularColor0 ("Specular Color 0", Color) = (1, 1, 1, 1)
		_SpecularColor1 ("Specular Color 1", Color) = (1, 1, 1, 1)
		_SpecularColor2 ("Specular Color 2", Color) = (1, 1, 1, 1)
		_SpecularColor3 ("Specular Color 3", Color) = (1, 1, 1, 1)

		_SpecDot0Min ("Spec Dot 0 Min", Float) = 0.4
		_SpecDot0Max ("Spec Dot 0 Max", Float) = 0.6
		_SpecDot1Min ("Spec Dot 1 Min", Float) = 0.4
		_SpecDot1Max ("Spec Dot 1 Max", Float) = 0.6
		_SpecDot2Min ("Spec Dot 2 Min", Float) = 0.4
		_SpecDot2Max ("Spec Dot 2 Max", Float) = 0.6
		_SpecDot3Min ("Spec Dot 3 Min", Float) = 0.4
		_SpecDot3Max ("Spec Dot 3 Max", Float) = 0.6

		_DiffuseColor ("Diffuse Color", Color) = (1, 1, 1, 1)

		
		_CameraPosition("Caemra Position", Vector) = (0, 0, 0, 0)
		_CameraDistanceFade("Camera Distance Fade", Vector) = (0.0, 20.0, 0.0, 0.0)

	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

		Cull Off

        CGPROGRAM
        #pragma surface surf SimplePhong fullforwardshadows vertex:vert
        #pragma target 3.0

        sampler2D _MainTex;
		
        struct Input
        {
            float2 uv_MainTex;
			float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;

        fixed4 _Color0;
		fixed4 _Color1;
		fixed4 _Color2;
		fixed4 _Color3;

		float  _SpecPower;

		fixed4 _SpecularColor0;
		fixed4 _SpecularColor1;
		fixed4 _SpecularColor2;
		fixed4 _SpecularColor3;

		float _SpecDot0Min;
		float _SpecDot0Max;
		float _SpecDot1Min;
		float _SpecDot1Max;
		float _SpecDot2Min;
		float _SpecDot2Max;
		float _SpecDot3Min;
		float _SpecDot3Max;

		fixed4 _DiffuseColor;

		float4 _CameraPosition;
		float4 _CameraDistanceFade;


		sampler2D _PositionTex; // 位置データ
		sampler2D _NormalTex;   // 法線データ


		void vert(inout appdata_full v)
		{
			// 位置情報を取得しセット
			v.vertex.xyz = tex2Dlod(_PositionTex, float4(v.texcoord.xy, 0.0, 0.0)).xyz;
			// 法線情報を取得しセット
			v.normal.xyz = tex2Dlod(_NormalTex,   float4(v.texcoord.xy, 0.0, 0.0)).xyz;
		}

		void surf(Input IN, inout SurfaceOutput  o) {
			fixed4 col = tex2D(_MainTex, IN.uv_MainTex);

			float wy = IN.worldPos.y * 0.025;
			
			col.xyz = lerp(_Color1, _Color0, col.r).xyz;
			
			o.Albedo = col;
		}

		half4 LightingSimplePhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half NdotL = max(0, dot(s.Normal, lightDir));
			float3 R = normalize(-lightDir + 2.0 * s.Normal * NdotL);
			float3 spec0 = pow(max(0, smoothstep(_SpecDot0Min, _SpecDot0Max, dot(R, viewDir))), _SpecPower) * _SpecularColor0.rgb;
			float3 spec1 = pow(max(0, smoothstep(_SpecDot1Min, _SpecDot1Max, dot(R, viewDir))), _SpecPower) * _SpecularColor1.rgb;
			float3 spec2 = pow(max(0, smoothstep(_SpecDot2Min, _SpecDot2Max, dot(R, viewDir))), _SpecPower) * _SpecularColor2.rgb;
			float3 spec3 = pow(max(0, smoothstep(_SpecDot3Min, _SpecDot3Max, dot(R, viewDir))), _SpecPower) * _SpecularColor3.rgb;

			float4 col = lerp(_Color1, _Color0, s.Albedo.r);

			half4 c;
			c.rgb = s.Albedo * _DiffuseColor.rgb * NdotL + spec0 + spec1 + spec2 + spec3 + fixed4(0.1f, 0.1f, 0.1f, 1);
			c.a = s.Alpha;
			return c;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
