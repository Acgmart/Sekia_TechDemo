Shader "Unlit/DebugSpringShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
	CGINCLUDE
	#include "UnityCG.cginc"

	struct v2g_mass
	{
		float4 vertex : POSITION;
	};

	struct g2f_mass
	{
		float4 position : SV_POSITION;
		float2 uv       : TEXCOORD0;
	};

	struct springIds
	{
		int2 a;
		int2 b;
	};

	struct v2g_spring
	{
		float4 vertex0 : POSITION;
		float4 vertex1 : TEXCOORD0;
	};

	struct g2f_spring
	{
		float4 position : SV_POSITION;
	};
	
	sampler2D _PositionTex;
	float4 _PositionTex_TexelSize;
	StructuredBuffer<springIds> _SpringIdsBuffer;

	float4 _Color;
	float  _ParticleSize;

	v2g_mass vert_mass(uint id : SV_VertexID)
	{
		v2g_mass o = (v2g_mass)0;
		float2 tr = _PositionTex_TexelSize.zw;
		float2 ts = _PositionTex_TexelSize.xy;
		float2 uv = float2(
			fmod(id, tr.x) * ts.x,
			floor(int(id / tr.x)) * ts.y
			);
		float3 v = tex2Dlod(_PositionTex, float4(uv.xy, 0, 0)).xyz;
		o.vertex = float4(v.xyz, 1.0);
		return o;
	}

	// ポイントスプライトの各頂点の位置
	static const float3 g_positions[4] =
	{
		float3(-1, 1, 0),
		float3(1, 1, 0),
		float3(-1,-1, 0),
		float3(1,-1, 0),
	};
	// 各頂点のUV座標値
	static const float2 g_texcoords[4] =
	{
		float2(0, 1),
		float2(1, 1),
		float2(0, 0),
		float2(1, 0),
	};

	[maxvertexcount(4)]
	void geom_mass(point v2g_mass In[1], inout TriangleStream<g2f_mass> SpriteStream)
	{
		g2f_mass o = (g2f_mass)0;

		float3 vertpos = In[0].vertex.xyz;
		[unroll]
		for (int i = 0; i < 4; i++)
		{
			float3 pos = g_positions[i] * _ParticleSize;
			pos = mul(unity_CameraToWorld, pos) + vertpos;
			o.position = UnityObjectToClipPos(float4(pos, 1.0));
			o.uv = g_texcoords[i];
			SpriteStream.Append(o);
		}
		SpriteStream.RestartStrip();
	}

	fixed4 frag_mass(g2f_mass i) : SV_Target
	{
		float2 diff = i.uv.xy - float2(0.5, 0.5);
		if (dot(diff, diff) > 0.25)
			discard;

		fixed4 col = _Color;
		return col;
	}

	v2g_spring vert_spring(uint id : SV_VertexID)
	{
		v2g_spring o = (v2g_spring)0;
		springIds ids = _SpringIdsBuffer[id];
		float4 v0 = tex2Dlod(_PositionTex, float4(ids.a * _PositionTex_TexelSize.xy, 0, 0));
		float4 v1 = tex2Dlod(_PositionTex, float4(ids.b * _PositionTex_TexelSize.xy, 0, 0));
		o.vertex0 = UnityObjectToClipPos(v0);
		o.vertex1 = UnityObjectToClipPos(v1);
		return o;
	}

	[maxvertexcount(2)]
	void geom_spring(point v2g_spring points[1], inout LineStream<g2f_spring> stream)
	{
		g2f_spring o = (g2f_spring)0;

		float4 pos0 = points[0].vertex0;
		float4 pos1 = points[0].vertex1;

		o.position = pos0;
		stream.Append(o);

		o.position = pos1;
		stream.Append(o);

		stream.RestartStrip();
	}

	fixed4 frag_spring(g2f_spring i) : SV_Target
	{
		fixed4 col = _Color;
		return col;
	}
	ENDCG

    SubShader
    {
		Tags{ "RenderType" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 100

		Blend  SrcAlpha One
		ZWrite Off
		
		// Pass 0: Draw Mass
		Pass
		{
			CGPROGRAM
			#pragma target   5.0
			#pragma vertex   vert_mass
			#pragma geometry geom_mass
			#pragma fragment frag_mass
			ENDCG
		}

		// Pass 1: Draw Spring
        Pass
        {
            CGPROGRAM
			#pragma target   5.0
            #pragma vertex   vert_spring
			#pragma geometry geom_spring
            #pragma fragment frag_spring
            ENDCG
        }
    }
}
