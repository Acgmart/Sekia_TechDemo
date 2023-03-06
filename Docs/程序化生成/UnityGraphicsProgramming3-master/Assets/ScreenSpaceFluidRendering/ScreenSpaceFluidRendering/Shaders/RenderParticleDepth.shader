Shader "Hidden/ScreenSpaceFluidRendering/RenderParticleColorAndDepth"
{
	CGINCLUDE
	#include "UnityCG.cginc"

	struct FluidParticle
	{
		float3 position;
		float3 velocity;
	};

	struct v2g
	{
		float4 position : POSITION_SV;
	};

	struct g2f
	{
		float4 position : POSITION;
		float  size     : TEXCOORD0;
		float2 uv       : TEXCOORD1;
		float3 vpos     : TEXCOORD2;
	};

	// パーティクルのデータを格納したバッファ
	StructuredBuffer<FluidParticle> _ParticleDataBuffer;
	// パーティクルのサイズ
	float _ParticleSize;
	
	// --------------------------------------------------------------------
	// Vertex Shader
	// --------------------------------------------------------------------
	v2g vert(uint id : SV_VertexID)
	{
		v2g o = (v2g)0;
		FluidParticle fp = _ParticleDataBuffer[id];
		o.position = float4(fp.position, 1.0);
		return o;
	}

	// --------------------------------------------------------------------
	// Geometry Shader
	// --------------------------------------------------------------------
	// ポイントスプライトの各頂点の位置
	static const float3 g_positions[4] =
	{
		float3(-1, 1, 0),
		float3( 1, 1, 0),
		float3(-1,-1, 0),
		float3( 1,-1, 0),
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
	void geom(point v2g In[1], inout TriangleStream<g2f> SpriteStream)
	{
		g2f o = (g2f)0;
		// ポイントスプライトの中心の頂点の位置
		float3 vertpos = In[0].position.xyz;
		// ポイントスプライト4点
		[unroll]
		for (int i = 0; i < 4; i++)
		{
			// クリップ座標系でのポイントスプライトの位置を求め代入
			float3 pos = g_positions[i] * _ParticleSize;
			pos = mul(unity_CameraToWorld, pos) + vertpos;
			o.position = UnityObjectToClipPos(float4(pos, 1.0));
			// ポイントスプライトの頂点のUV座標を代入
			o.uv       = g_texcoords[i];
			// 視点座標系でのポイントスプライトの位置を求め代入
			o.vpos     = UnityObjectToViewPos(float4(pos, 1.0)).xyz * float3(1, 1, 1);
			// ポイントスプライトのサイズを代入
			o.size     = _ParticleSize;

			SpriteStream.Append(o);
		}
		SpriteStream.RestartStrip();
	}

	// --------------------------------------------------------------------
	// Fragment Shader
	// --------------------------------------------------------------------
	struct fragmentOut
	{
		float  depthBuffer  : SV_Target0;
		float  depthStencil : SV_Depth;
	};

	fragmentOut frag(g2f i)
	{
		// 法線を計算
		float3 N = (float3)0;
		N.xy = i.uv.xy * 2.0 - 1.0;
		float radius_sq = dot(N.xy, N.xy);
		if (radius_sq > 1.0) discard;
		N.z = sqrt(1.0 - radius_sq);

		// クリップ空間でのピクセルの位置
		float4 pixelPos     = float4(i.vpos.xyz + N * i.size, 1.0);
		float4 clipSpacePos = mul(UNITY_MATRIX_P, pixelPos);
		// 深度
		float  depth = clipSpacePos.z / clipSpacePos.w; // 正規化
		
		fragmentOut o  = (fragmentOut)0;
		o.depthBuffer  = depth;
		o.depthStencil = depth;
		
		return o;
	}

	ENDCG

	SubShader
	{
		Tags { "RenderType" = "Opaque" "DisableBatching" = "True" "RenderQueue"="Geometry" }
		Cull Off
		ZWrite On

		Pass
		{
			CGPROGRAM
			#pragma target   5.0
			#pragma vertex   vert
			#pragma geometry geom
			#pragma fragment frag			
			ENDCG
		}
	}
}
