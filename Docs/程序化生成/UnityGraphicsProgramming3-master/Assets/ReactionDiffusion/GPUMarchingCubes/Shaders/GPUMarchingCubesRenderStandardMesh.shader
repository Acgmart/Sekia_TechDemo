Shader "Custom/GPUMarching Cubes Render Standard Mesh"
{
	Properties
	{
		_MainTex ("Texture", 3D) = "" {}
		_Width("Width", int) = 32
		_Height("Height", int) = 32
		_Depth("Depth", int) = 32

		_Scale("Scale", float) = 1
		_SampleScale("Sample Scale", float) = 0.1
		_Threashold("Threashold", float) = 0.5

		_DiffuseColor("Diffuse", Color) = (0,0,0,1)

		_EmissionIntensity("Emission Intensity", Range(0,1)) = 1
		_EmissionColor("Emission", Color) = (0,0,0,1)

		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_Occlusion("Occlusion", Range(0,1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }

		CGINCLUDE
#include "UnityCG.cginc"
#include "UnityGBuffer.cginc"
#include "UnityStandardUtils.cginc"
#include "Libs/MarchingCubesTables.cginc"

		struct appdata
		{
			float4 vertex	: POSITION;
			float2 uv		: TEXCOORD0;
		};

		struct v2g
		{
			float4 pos		: SV_POSITION;
			float4 tangent	: TANGENT;
			float3 normal	: NORMAL;
			fixed4 color	: COLOR;
		};

		struct g2f_light
		{
			float4 pos			: SV_POSITION;
			float3 normal		: NORMAL;
			float4 worldPos		: TEXCOORD0;
			float2 texcoord		: TEXCOORD1;
			half3 ambient		: TEXCOORD2;
		};
		
		struct g2f_shadow
		{
			float4 pos		: SV_POSITION;
		};

		int _Width;
		int _Height;
		int _Depth;

		float _Scale;
		float _SampleScale;
		float _Threashold;

		float4 _DiffuseColor;
		float3 _HalfSize;
		float4x4 _Matrix;

		float _EmissionIntensity;
		half4 _EmissionColor;

		half _Glossiness;
		half _Metallic;
		half _Occlusion;

		sampler3D _MainTex;


		float Sample(float x, float y, float z)
		{

			if ((x <= 1) || (y <= 1) || (z <= 1) || (x >= (_Width - 1)) || (y >= (_Height - 1)) || (z >= (_Depth - 1)))
				return 0;

			float4 uv = float4(x / _Width, y / _Height, z / _Depth, 0) * _SampleScale;

			float4 c = tex3Dlod(_MainTex, uv);
			return c.r;
		}

		float Sample(float3 pos)
		{
			return Sample(pos.x, pos.y, pos.z);
		}

		// オフセット計算（2値の間の閾値(desired)に近い点を計算する）
		float getOffset(float val1, float val2, float desired) {
			float delta = val2 - val1;
			return (delta == 0.0) ? 0.5 : (desired - val1) / delta;
		}

		// 法線計算
		float3 getNormal(float fX, float fY, float fZ)
		{
			float3 normal;
			float offset = 1.0;	// 隣のグリッド

			normal.x = Sample(fX - offset, fY, fZ) - Sample(fX + offset, fY, fZ);
			normal.y = Sample(fX, fY - offset, fZ) - Sample(fX, fY + offset, fZ);
			normal.z = Sample(fX, fY, fZ - offset) - Sample(fX, fY, fZ + offset);

			return normal;
		}

		//v2g vert(uint id : SV_VertexID)
		v2g vert(appdata v)
		{
			v2g o = (v2g)0;
			o.pos = v.vertex;
			return o;
		}

		// ジオメトリシェーダ(light用)
		[maxvertexcount(18)]
		void geom_light(point v2g input[1], inout TriangleStream<g2f_light> outStream)
		{
			g2f_light o = (g2f_light)0;

			int i, j;
			float cubeValue[8];
			float3 edgeVertices[12] = {
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0) };
			float3 edgeNormals[12] = {
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0) };

			float3 pos = input[0].pos.xyz;
			float3 defpos = pos;

			// グリッドの８つの角のスカラー値を取得
			for (i = 0; i < 8; i++) {
				cubeValue[i] = Sample(pos + vertexOffset[i]);
			}

			pos *= _Scale;
			pos -= _HalfSize;
			//pos = mul(_Matrix, pos);

			int flagIndex = 0;

			// グリッドの８つの角の値が閾値を超えているかチェック
			for (i = 0; i < 8; i++) {
				if (cubeValue[i] <= _Threashold) {
					flagIndex |= (1 << i);
				}
			}

			int edgeFlags = cubeEdgeFlags[flagIndex];

			// 空か完全に満たされている場合は何も描画しない
			if ((edgeFlags == 0) || (edgeFlags == 255)) {
				return;
			}

			float offset = 0.5;
			float3 vertex;
			for (i = 0; i < 12; i++) {
				if ((edgeFlags & (1 << i)) != 0) {
					// 角同士の閾値のオフセットを取得
					offset = getOffset(cubeValue[edgeConnectionX[i]], cubeValue[edgeConnectionY[i]], _Threashold);

					// オフセットを元に頂点の座標を補完
					vertex.x = (vertexOffsetX[edgeConnectionX[i]] + offset * edgeDirectionX[i]);
					vertex.y = (vertexOffsetY[edgeConnectionX[i]] + offset * edgeDirectionY[i]);
					vertex.z = (vertexOffsetZ[edgeConnectionX[i]] + offset * edgeDirectionZ[i]);

					edgeVertices[i].x = pos.x + vertex.x * _Scale;
					edgeVertices[i].y = pos.y + vertex.y * _Scale;
					edgeVertices[i].z = pos.z + vertex.z * _Scale;

					// 法線計算（Sampleし直すため、スケールを掛ける前の頂点座標が必要）
					edgeNormals[i] = getNormal(defpos.x + vertex.x, defpos.y + vertex.y, defpos.z + vertex.z);
				}
			}

			// 頂点を連結してポリゴンを作成
			int vindex = 0;
			int findex = 0;
			// 最大４つの三角形ができる
			for (i = 0; i < 5; i++) {
				findex = flagIndex * 16 + 3 * i;
				if (triangleConnectionTable[findex] < 0)
					break;

				// Normal(flat shading)
				//float3 v0 = edgeVertices[triangleConnectionTable[findex + 1]] - edgeVertices[triangleConnectionTable[findex]];
				//float3 v1 = edgeVertices[triangleConnectionTable[findex + 2]] - edgeVertices[triangleConnectionTable[findex]];
				//float3 norm = UnityObjectToWorldNormal(normalize(cross(v0, v1)));

				// 三角形を作る
				for (j = 0; j < 3; j++) {
					vindex = triangleConnectionTable[findex + j];

					// Transform行列を掛けてワールド座標に変換
					float4 ppos = mul(_Matrix, float4(edgeVertices[vindex], 1));
					o.pos = UnityObjectToClipPos(ppos);
					// 滑らかシェーディング
					float3 norm = UnityObjectToWorldNormal(normalize(edgeNormals[vindex]));
					o.normal = normalize(mul(_Matrix, float4(norm,0)));
					o.ambient = ShadeSHPerVertex(norm, 0);

					outStream.Append(o);
				}
				outStream.RestartStrip();
			}
		}

		void frag_light(g2f_light IN,
			out half4 outGBuffer0 : SV_Target0,
			out half4 outGBuffer1 : SV_Target1,
			out half4 outGBuffer2 : SV_Target2,
			out half4 outEmission : SV_Target3)
		{
			fixed3 normal = IN.normal;

			float3 worldPos = IN.worldPos;

			fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

			half3 c_diff, c_spec;
			half refl10;
			c_diff = DiffuseAndSpecularFromMetallic(
				_DiffuseColor.rgb, _Metallic, // input
				c_spec, refl10     // output
			);

#ifdef UNITY_COMPILER_HLSL
			UnityStandardData o = (UnityStandardData)0;
#else
			UnityStandardData o;
#endif
			o.diffuseColor = c_diff;
			o.occlusion = _Occlusion;
			o.specularColor = c_spec;
			o.smoothness = _Glossiness;
			o.normalWorld = IN.normal;
			UnityStandardDataToGbuffer(o, outGBuffer0, outGBuffer1, outGBuffer2);

			// call lighting function to output g-buffer
			half3 sh = ShadeSHPerPixel(IN.normal, IN.ambient, IN.worldPos);
			outEmission = _EmissionColor * _EmissionIntensity + half4(sh * c_diff, 1) * _Occlusion;

#ifndef UNITY_HDR_ON
			outEmission.rgb = exp2(-outEmission.rgb);
#endif
		}

		// ジオメトリシェーダ(shadow用)
		[maxvertexcount(18)]
		void geom_shadow(point v2g input[1], inout TriangleStream<g2f_shadow> outStream)
		{
			g2f_shadow o = (g2f_shadow)0;

			int i, j;
			float cubeValue[8];
			float3 edgeVertices[12] = {
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0) };
			float3 edgeNormals[12] = {
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0),
				float3(0, 0, 0) };

			float3 pos = input[0].pos.xyz;
			float3 defpos = pos;

			for (i = 0; i < 8; i++) {
				cubeValue[i] = Sample(pos + vertexOffset[i]);
			}

			pos *= _Scale;
			pos -= _HalfSize;

			int flagIndex = 0;

			for (i = 0; i < 8; i++) {
				if (cubeValue[i] <= _Threashold) {
					flagIndex |= (1 << i);
				}
			}

			int edgeFlags = cubeEdgeFlags[flagIndex];

			if ((edgeFlags == 0) || (edgeFlags == 255)) {
				return;
			}

			float offset = 0.5;
			float3 vertex;
			for (i = 0; i < 12; i++) {
				if ((edgeFlags & (1 << i)) != 0) {
					offset = getOffset(cubeValue[edgeConnectionX[i]], cubeValue[edgeConnectionY[i]], _Threashold);

					vertex.x = (vertexOffsetX[edgeConnectionX[i]] + offset * edgeDirectionX[i]);
					vertex.y = (vertexOffsetY[edgeConnectionX[i]] + offset * edgeDirectionY[i]);
					vertex.z = (vertexOffsetZ[edgeConnectionX[i]] + offset * edgeDirectionZ[i]);

					edgeVertices[i].x = pos.x + vertex.x * _Scale;
					edgeVertices[i].y = pos.y + vertex.y * _Scale;
					edgeVertices[i].z = pos.z + vertex.z * _Scale;

					edgeNormals[i] = getNormal(defpos.x + vertex.x, defpos.y + vertex.y, defpos.z + vertex.z);
				}
			}

			int vindex = 0;
			int findex = 0;
			for (i = 0; i < 5; i++) {
				findex = flagIndex * 16 + 3 * i;
				if (triangleConnectionTable[findex] < 0)
					break;

				// Normal
				//float3 v0 = edgeVertices[triangleConnectionTable[findex + 1]] - edgeVertices[triangleConnectionTable[findex]];
				//float3 v1 = edgeVertices[triangleConnectionTable[findex + 2]] - edgeVertices[triangleConnectionTable[findex]];
				//float3 norm = normalize(cross(v0, v1));
				//float3 defnorm = UnityObjectToWorldNormal(normalize(cross(v0, v1)));

				for (j = 0; j < 3; j++) {
					vindex = triangleConnectionTable[findex + j];

					float4 ppos = mul(_Matrix, float4(edgeVertices[vindex], 1));

					float3 norm;
					norm = UnityObjectToWorldNormal(normalize(edgeNormals[vindex]));

					float4 lpos1 = mul(unity_WorldToObject, ppos);
					o.pos = UnityClipSpaceShadowCasterPos(lpos1, normalize(mul(_Matrix, float4(norm, 0))));
					o.pos = UnityApplyLinearShadowBias(o.pos);
					
					outStream.Append(o);
				}
				outStream.RestartStrip();
			}
		}

		fixed frag_shadow(g2f_shadow i) : SV_Target
		{
			return 0;
		}
		ENDCG

		Pass{
			Tags{ "LightMode" = "Deferred" }

			
			CGPROGRAM
			#pragma target 5.0
			#pragma vertex vert
			#pragma geometry geom_light
			#pragma fragment frag_light
			#pragma exclude_renderers nomrt
			#pragma multi_compile_prepassfinal noshadowmask nodynlightmap nodirlightmap nolightmap

			ENDCG
		}

		Pass {
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On ZTest LEqual
			CGPROGRAM
			#pragma target 5.0
			#pragma vertex vert
			#pragma geometry geom_shadow
			#pragma fragment frag_shadow
			#pragma multi_compile_shadowcaster noshadowmask nodynlightmap nodirlightmap nolightmap

			ENDCG
		}
	}

	FallBack "Diffuse"
}
