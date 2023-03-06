Shader "CellularGrowth/Edge"
{

	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
    _Length ("Length", Range(1, 10)) = 2.0
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Transparent-1" }
		LOD 100

		Pass
		{
      Blend SrcAlpha One
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
			#include "../Common/Edge.cginc"

      struct appdata
      {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
        uint vid : SV_VertexID;
        UNITY_VERTEX_INPUT_INSTANCE_ID
      };

			struct v2f
			{
				float4 position : SV_POSITION;
        float alpha : COLOR;
        UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			StructuredBuffer<Particle> _Particles;
			StructuredBuffer<Edge> _Edges;

			float4 _Color;
      float _Length;

      float4x4 _World2Local, _Local2World;

      void setup() {
        unity_WorldToObject = _World2Local;
        unity_ObjectToWorld = _Local2World;
      }

      v2f vert(appdata IN, uint iid : SV_InstanceID)
      {
        v2f OUT;
        UNITY_SETUP_INSTANCE_ID(IN);
        UNITY_TRANSFER_INSTANCE_ID(IN, OUT);

        Edge e = _Edges[iid];
        Particle pa = _Particles[e.a];
        Particle pb = _Particles[e.b];
        float3 position = lerp(float3(pa.position, 0), float3(pb.position, 0), IN.vid);
        float4 vertex = float4(position, 1);
        OUT.position = UnityObjectToClipPos(vertex);

        float r = pa.radius + pb.radius;
        float d = distance(pa.position, pb.position);
        float alpha = saturate((r * _Length) / d);
        OUT.alpha = alpha * e.alive;
        return OUT;
      }

      fixed4 frag(v2f IN) : SV_Target
      {
        return _Color * IN.alpha;
      }

			ENDCG
		}
	}
}
