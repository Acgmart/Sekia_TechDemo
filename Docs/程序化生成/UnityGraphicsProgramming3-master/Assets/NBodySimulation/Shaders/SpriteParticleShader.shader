
Shader "NBodySim/SpriteParticleShader" 
{

	Properties
	{
		_Sprite("Sprite", 2D) = "white" {}
		_Color("Color", Color) = (0.38,0.26,0.98,1.0)
		_Size("Size", float) = 0.1
	}
	SubShader 
	{
		//uses DrawProcedural so tag doesnt really matter
		Tags { "Queue" = "Transparent" }
	
		Pass 
		{
		
		ZWrite Off 
		ZTest Always 
		Cull Off 
		Fog { Mode Off }
    	Blend one one

		CGPROGRAM
		#pragma target 5.0

		#pragma vertex vert
		#pragma geometry geom
		#pragma fragment frag

		#include "UnityCG.cginc"

		StructuredBuffer<float4> _Positions;
		StructuredBuffer<float4> _Colors;
		fixed4 _Color;
		float _Size;
		sampler2D _Sprite;

		struct v2g 
		{
			float4 pos : SV_POSITION;
			int id : TEXCOORD0;
		};

		v2g vert(uint id : SV_VertexID)
		{
			v2g OUT;
			float3 worldPos = _Positions[id].xyz;
			OUT.pos = mul (UNITY_MATRIX_VP, float4(worldPos,1.0f));
			OUT.id = id;
			return OUT;
		}
		
		struct g2f {
		float4 pos : SV_POSITION;
		float2 uv : TEXCOORD0;
		};

		[maxvertexcount(4)]
		void geom(point v2g IN[1], inout TriangleStream<g2f> outStream)
		{
			float dx = _Size;
			float dy = _Size * _ScreenParams.x / _ScreenParams.y;
			g2f OUT;
			OUT.pos = IN[0].pos + float4(-dx, dy,0,0); OUT.uv=float2(0,0); outStream.Append(OUT);
			OUT.pos = IN[0].pos + float4( dx, dy,0,0); OUT.uv=float2(1,0); outStream.Append(OUT);
			OUT.pos = IN[0].pos + float4(-dx,-dy,0,0); OUT.uv=float2(0,1); outStream.Append(OUT);
			OUT.pos = IN[0].pos + float4( dx,-dy,0,0); OUT.uv=float2(1,1); outStream.Append(OUT);
			outStream.RestartStrip();
		}

		float4 frag (g2f IN) : COLOR
		{
			return tex2D(_Sprite, IN.uv) * _Color;
		}

		ENDCG

		}
	}

Fallback Off
}















