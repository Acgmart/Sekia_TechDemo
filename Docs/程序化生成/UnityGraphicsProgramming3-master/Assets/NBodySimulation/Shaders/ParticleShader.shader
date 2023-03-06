
Shader "NBodySim/ParticleShader" 
{

	Properties
	{
		_MainTex("Particle", 2D) = "white" {}
		_Color("Color", Color) = (0.38,0.26,0.98,1.0)
		_Scale("Scale", Float) = 0.01
	}
	SubShader 
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
	
		Pass 
		{
		
			ZWrite Off
    		Blend One One

			CGPROGRAM
			#pragma target 5.0

			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Body.cginc"

			StructuredBuffer<Body> _Particles;
		
			sampler2D _MainTex;
			fixed4 _Color;
			float _Scale;

			struct v2g 
			{
				float4 pos : SV_POSITION;
				int id : TEXCOORD0;
			};

			struct g2f {
				float4 pos : SV_POSITION;
				int id : TEXCOORD1;
				float2 uv : TEXCOORD0;
			};

			v2g vert(uint id : SV_VertexID)
			{
				v2g o;

				o.pos = float4(_Particles[id].position, 1);
				o.id = id;
			
				return o;
			}


			[maxvertexcount(4)]
			void geom(point v2g input[1], inout TriangleStream<g2f> outStream) {
				g2f o;

				float4 pos = input[0].pos;

				float4x4 billboardMatrix = UNITY_MATRIX_V;

				// 回転成分だけ取り出す
				billboardMatrix._m03 = billboardMatrix._m13 = billboardMatrix._m23 = billboardMatrix._m33 = 0;


				for (int x = 0; x < 2; x++) {
					for (int y = 0; y < 2; y++) {
						float2 uv = float2(x, y);
						o.uv = uv;

						// 同じ意味
						// o.pos = pos + mul(float4((uv * 2 - float2(1, 1)) * _Scale * (1.1 - input[0].mass), 0, 1), billboardMatrix);
						o.pos = pos + mul(transpose(billboardMatrix), float4((uv * 2 - float2(1, 1)) * _Scale, 0, 1));

						o.pos = mul(UNITY_MATRIX_VP, o.pos);

						o.id = input[0].id;

						outStream.Append(o);
					}
				}

				outStream.RestartStrip();
			}


			float3 hsv2rgb_smooth(float3 c)
			{
				float3 rgb = clamp(abs(fmod(c.x*6.0 + float3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);

				rgb = rgb * rgb*(3.0 - 2.0*rgb); // cubic smoothing	

				return c.z * lerp((float3)1, rgb, (float3)c.y);
			}


			float4 frag (g2f IN) : COLOR
			{
				float2 uv = IN.uv;

				float4 col = tex2D(_MainTex, uv);

				col.rgb *= hsv2rgb_smooth(float3(sin(_Time.x) * 0.5 + 0.5, 0.8, 1));

				return col;
			}

			ENDCG

		}
	}

}

















