Shader "Hidden/SphereGeometry"
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

            #define THETA_COUNT 7
            #define PHI_COUNT 15

            #define STEP_THETA (UNITY_PI / (THETA_COUNT + 1))
            #define STEP_PHI (UNITY_TWO_PI / PHI_COUNT)

            #define VERTEX_COUNT (THETA_COUNT * PHI_COUNT + 2)

            uniform float4 _Color;
            uniform float _Radius;
            uniform Buffer<float3> _Points;

            v2g vert (uint id : SV_VertexID)
            {
                v2g o;
                o.id = id;
                return o;
            }

            float3 getCoordinates(float theta, float phi)
            {
                return float3(
                    sin(theta) * cos(phi),
                    cos(theta),
                    sin(theta) * sin(phi)
                    );
            }

            float4 getPos(float3 center, float radius, float theta, float phi)
            {
                return mul(UNITY_MATRIX_VP, float4(center + radius * getCoordinates(theta, phi), 1.0f));
            }

            [maxvertexcount(256)]
            void geom(point v2g input[1], inout TriangleStream<g2f> outStream)
            {
                v2g data = input[0];
                g2f output[VERTEX_COUNT];

                float radius = _Radius;
                float3 center = _Points[data.id];
                output[0].pos = mul(UNITY_MATRIX_VP, float4(center.xyz, 1.0));

                // Vertices.
                int id = 0;
                output[id++].pos = getPos(center, radius, 0.0f, 0.0f);

                [unroll]
                for (int i = 1; i <= THETA_COUNT; i++)
                {
                    float theta = STEP_THETA * i;
                    [unroll]
                    for (int j = 0; j < PHI_COUNT; j++)
                    {
                        output[id++].pos = getPos(center, radius, theta, STEP_PHI * j);
                    }
                }

                output[id++].pos = getPos(center, radius, UNITY_PI, 0.0f);

                // Triangles.
                for (i = 1; i <= PHI_COUNT; i++)
                {
                    outStream.Append(output[0]);

                    for (int j = 0; j < THETA_COUNT; j++)
                    {
                        int index = j * PHI_COUNT + i;
                        int next = index + 1;

                        next = next - PHI_COUNT * min(max(next - PHI_COUNT * (j + 1), 0), 1);

                        outStream.Append(output[next]);
                        outStream.Append(output[index]);
                    }

                    outStream.Append(output[VERTEX_COUNT - 1]);
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
