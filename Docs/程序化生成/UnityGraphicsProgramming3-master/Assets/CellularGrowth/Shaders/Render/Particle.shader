Shader "CellularGrowth/Particle"
{

	Properties
	{
    _Texture ("Shape", 2D) = "white" {}
		_Gradient ("Gradient", 2D) = "white" {}
    _Size ("Size", Range(0.0, 1.0)) = 0.75
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Transparent" }
		LOD 100

		Pass
		{
      Blend SrcAlpha OneMinusSrcAlpha
      ZTest Always

      Cull Off

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#pragma instancing_options procedural:setup
			
			#include "UnityCG.cginc"
			#include "../Common/Random.cginc"
			#include "../Common/Particle.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
        UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float4 position : SV_POSITION;
        float2 uv : TEXCOORD0;
        float4 color : COLOR;
        UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			StructuredBuffer<Particle> _Particles;
      float _Size;

      float4x4 _World2Local, _Local2World;

      sampler2D _Texture, _Gradient;

      void setup() {
        unity_WorldToObject = _World2Local;
        unity_ObjectToWorld = _Local2World;
      }

			v2f vert (appdata IN, uint iid : SV_InstanceID)
			{
				v2f OUT;
        UNITY_SETUP_INSTANCE_ID(IN);
        UNITY_TRANSFER_INSTANCE_ID(IN, OUT);

        Particle p = _Particles[iid];
        float4 vertex = IN.vertex * p.alive * p.radius * 2.0 * _Size + float4(p.position.xy, 0, 0);
        OUT.position = UnityObjectToClipPos(vertex);
        OUT.uv = IN.uv;

        float u = saturate(nrand(float2(iid, 0)));
        float4 grad = tex2Dlod(_Gradient, float4(u, 0.5, 0, 0));
        OUT.color = grad;
				return OUT;
			}

			fixed4 frag (v2f IN) : SV_Target
			{
				return IN.color * tex2D(_Texture, IN.uv);
			}

			ENDCG
		}
	}
}
