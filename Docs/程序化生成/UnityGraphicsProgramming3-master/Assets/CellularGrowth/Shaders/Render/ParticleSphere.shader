Shader "CellularGrowth/ParticleSphere"
{

	Properties
	{
		_Gradient ("Gradient", 2D) = "white" {}
    _Spec ("Specular", Color) = (0.1, 0.1, 0.1, 0.8)
    _Size ("Size", Range(0.0, 1.0)) = 0.75
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" "LightMode" = "Deferred"  }
		LOD 100

		Pass
		{
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
        float4 color : COLOR;
        float2 uv : TEXCOORD0;
        float3 vposition : TEXCOORD1;
        float3 vright : TEXCOORD2;
        float3 vup : TEXCOORD3;
        float3 vforward : TEXCOORD4;
        UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			StructuredBuffer<Particle> _Particles;

      float4x4 _World2Local, _Local2World;

      sampler2D _Gradient;
      float4 _Spec;
      float _Size;

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
        OUT.vposition = UnityObjectToViewPos(vertex);
        OUT.vright = normalize(UNITY_MATRIX_V[0].xyz);
        OUT.vup = normalize(UNITY_MATRIX_V[1].xyz);
        OUT.vforward = normalize(UNITY_MATRIX_V[2].xyz);
        OUT.uv = IN.uv;

        float u = saturate(nrand(float2(iid, 0)));
        float4 grad = tex2Dlod(_Gradient, float4(u, 0.5, 0, 0));
        OUT.color = grad;
				return OUT;
			}

      void frag(
        v2f IN,
        out half4 outDiffuse : SV_Target0,
        out half4 outSpecSmoothness : SV_Target1,
        out half4 outNormal : SV_Target2,
        out half4 outEmission : SV_Target3,
        out half outDepth : SV_Depth
      )
      {
        half3 normal;
        normal.xy = IN.uv*2.0 - 1.0;
        half r2 = dot(normal.xy, normal.xy);
        if (r2 > 1.0)
          discard;
        normal.z = sqrt(1.0 - r2);

        half4 vp = half4(IN.vposition.xyz + normal * _Size, 1.0);
        half4 cp = mul(UNITY_MATRIX_P, vp);
#if defined(SHADER_API_D3D11)
        outDepth = cp.z / cp.w;
#else
        outDepth = (cp.z / cp.w) * 0.5 + 0.5;
#endif
        if (outDepth <= 0)
          discard;

        outDiffuse = IN.color;
        outSpecSmoothness = _Spec;
        outNormal.xyz = normalize(normal.x * IN.vright + normal.y * IN.vup + normal.z * IN.vforward);
        outNormal = half4(outNormal.xyz * 0.5 + 0.5, 1);
        outEmission = 0;
      }

			ENDCG
		}
	}
}
