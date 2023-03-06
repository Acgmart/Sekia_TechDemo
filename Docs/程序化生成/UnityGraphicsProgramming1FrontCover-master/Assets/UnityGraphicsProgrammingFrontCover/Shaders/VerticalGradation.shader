Shader "Hidden/UnityGraphicsProgrammingFrontCover/VerticalGradation"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}

		_Color0 ("Color 0", Color) = (1,1,1,1)
		_Color1 ("Color 1", Color) = (0,0,0,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			float4 _Color0;
			float4 _Color1;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = lerp(_Color0, _Color1, i.uv.y);
				return col;
			}
			ENDCG
		}
	}
}
