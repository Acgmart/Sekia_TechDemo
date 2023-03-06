Shader "Hidden/CircleGeometry"
{
    Properties
    {
        _Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2g
            {
                uint id : ANY;
            };

            struct g2f
            {
                float4 pos : SV_POSITION;
            };

            #define PHI_COUNT 45
            #define STEP_PHI (UNITY_TWO_PI / PHI_COUNT)

            uniform float4 _Color;
            uniform float _Radius;
            uniform Buffer<float2> _Points;

            v2g vert (uint id : SV_VertexID)
            {
                v2g o;
                o.id = id;
                return o;
            }

            float4 getPos(float3 center, float radius, float phi)
            {
                return mul(UNITY_MATRIX_VP, float4(center + radius * float3(cos(phi), 0.0, sin(phi)), 1.0f));
            }

            [maxvertexcount(256)]
            void geom(point v2g input[1], inout TriangleStream<g2f> outStream)
            {
                v2g data = input[0];
                g2f output[PHI_COUNT + 1];

                float radius = _Radius;
                float3 center = float3(_Points[data.id].x, 0.0, _Points[data.id].y);
                output[0].pos = mul(UNITY_MATRIX_VP, float4(center.xyz, 1.0));

                // Vertices.
                [unroll]
                for (int i = 0; i < PHI_COUNT; i++)
                {
                    output[i + 1].pos = getPos(center, radius, STEP_PHI * i);
                }

                // Triangles.
                [unroll]
                for (i = 1; i <= PHI_COUNT; i++)
                {
                    int next = i + 1 > PHI_COUNT ? 1 : i + 1;

                    outStream.Append(output[0]);
                    outStream.Append(output[next]);
                    outStream.Append(output[i]);

                    outStream.RestartStrip();
                }
            }

            fixed4 frag (g2f i) : SV_Target
            {
                return _Color;
            }
            ENDCG
        }
    }
}
