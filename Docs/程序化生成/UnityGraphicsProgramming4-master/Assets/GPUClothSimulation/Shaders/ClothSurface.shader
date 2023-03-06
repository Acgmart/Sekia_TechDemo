Shader "Hidden/GPUClothSimulation/ClothSurface"
{
    Properties
    {
        _Color      ("Color",        Color     ) = (1,1,1,1)
        _MainTex    ("Albedo (RGB)", 2D        ) = "white" {}
        _Glossiness ("Smoothness",   Range(0,1)) = 0.5
        _Metallic   ("Metallic",     Range(0,1)) = 0.0

		_PositionTex ("Position Tex", 2D) = "black" {}
		_NormalTex   ("Normal Tex",   2D) = "gray"  {}

	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

		Cull Off

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert
        #pragma target 3.0

        sampler2D _MainTex;
		
        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;

        fixed4 _Color;

		sampler2D _PositionTex; // 位置データ
		sampler2D _NormalTex;   // 法線データ

		void vert(inout appdata_full v)
		{
			// 位置情報を取得しセット
			v.vertex.xyz = tex2Dlod(_PositionTex, float4(v.texcoord.xy, 0.0, 0.0)).xyz;
			// 法線情報を取得しセット
			v.normal.xyz = tex2Dlod(_NormalTex,   float4(v.texcoord.xy, 0.0, 0.0)).xyz;
		}

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex.xy) * _Color;
            o.Albedo     = c.rgb;
			o.Metallic   = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha      = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
