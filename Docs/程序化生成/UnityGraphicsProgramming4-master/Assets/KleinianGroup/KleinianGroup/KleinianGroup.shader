Shader "Custom/KleinianGroup"
{
    Properties
    {
        _HitColor("HitColor", Color) = (1,0,0,1)
        _BackColor("BackColor", Color) = (0.5,0.5,0.5,1)
        _Iteration("Iteration", int) = 500
        _Scale("Scale", float) = 1
        _Offset("Offsset", Vector) = (0,0,0,0)
        _KleinUV("KleinUV", Vector) = (2,0,0,0)
        _Circle("Circle", Vector) = (0,0,0,1)
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        CGINCLUDE
        #include "UnityCG.cginc"

        float4 _HitColor;
        float4 _BackColor;
        uint _Iteration;
        float _Scale;
        float2 _Offset;
        float2 _KleinUV;

        float wrap(float x, float width, float left_side){
            x -= left_side; 
            return (x - width * floor(x/width)) + left_side;
        }

        float2 TransA(float2 z, float2 t){
            return float2(z.x, -z.y) / dot(z,z) + float2(-t.y, t.x);
        }

        bool josKleinian(float2 z, float2 t)
        {
            float u = t.x;
            float v = t.y;

            float2 lz=z+(1).xx;
            float2 llz=z+(-1).xx;

            for (uint i = 0; i < _Iteration ; i++) 
            {
                // wrap if outside of Line1,2
                float offset_x = abs(v) / u * z.y;
                z.x += offset_x;
                z.x = wrap(z.x, 2, -1);
                z.x -= offset_x;
                            
                //if above Line3, inverse at (-v/2, u/2)
                float separate_line = u * 0.5 
                    + sign(v) *(2 * u - 1.95) / 4 * sign(z.x + v * 0.5)
                    * (1 - exp(-(7.2 - (1.95 - u) * 15)* abs(z.x + v * 0.5)));

                if  (z.y >= separate_line)
                {
                    z = float2(-v, u) - z;
                }
                
                z = TransA(z, t);

                //hit!
                if (z.y<0) { return true; }

                //2cycle
                if(length(z-llz) < 1e-6) {break;}

                llz=lz;
				lz=z;
            }

            return false;
        }

        float4 calc_color(float2 pos)
        {
            bool hit = josKleinian(pos, _KleinUV);
            return hit ? _HitColor : _BackColor;
        }

        // https://www.shadertoy.com/view/MlGfDG
        float2 rand2n(float2 co, float sampleIndex) {
            float2 seed = co * (sampleIndex + 1.0);
            seed += float2(-1, 1);
            // implementation based on: lumina.sourceforge.net/Tutorials/Noise.html
            return float2(frac(sin(dot(seed.xy, float2(12.9898, 78.233))) * 43758.5453),
                frac(cos(dot(seed.xy, float2(4.898, 7.23))) * 23421.631));
        }

        ENDCG


        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag

            fixed4 frag(v2f_img i) : SV_Target
            {
                float2 pos = i.uv;
                float aspect = _ScreenParams.x / _ScreenParams.y;
                pos.x *= aspect;
                pos += _Offset;
                pos *= _Scale;

                bool hit = josKleinian(pos, _KleinUV);
                return hit ? _HitColor : _BackColor;
            }

            ENDCG
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_multisample

            // ジラジラ対策でjosKleinian()をずらして平均をとる実装
            fixed4 frag_multisample(v2f_img i) : SV_Target
            {
                float2 pos = i.uv;
                float aspect = _ScreenParams.x / _ScreenParams.y;
                pos.x *= aspect;
                pos += _Offset;
                pos *= _Scale;

                int sample_num = 20;
                float4 sum;
                for (int i = 0; i < sample_num; ++i)
                {
                    float2 offset = rand2n(pos, i) * (1/_ScreenParams.y) * 3;
                    sum += calc_color(pos + offset);
                }

                return sum / sample_num;
            }

            ENDCG
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag_circle_inverse

            float4 _Circle;

            float2 circleInverse(float2 pos, float2 center, float radius)
            {
                float2 p = pos - center;
                p = (p * radius) / dot(p,p);
                p += center;
                return p;
            }


            fixed4 frag_circle_inverse(v2f_img i) : SV_Target
            {
                float2 pos = i.uv;
                float aspect = _ScreenParams.x / _ScreenParams.y;
                pos.x *= aspect;
                pos *= _Scale;
                pos += _Offset;

#if 0
                pos = circleInverse(pos, _Circle.xy, _Circle.w);

                bool hit = josKleinian(pos, _KleinUV);
                return hit ? _HitColor : _BackColor;
#else
                int sample_num = 10;
                float4 sum;
                for (int i = 0; i < sample_num; ++i)
                {
                    float2 offset = rand2n(pos, i) * (1/_ScreenParams.y) * 3;
                    float2 p = circleInverse(pos + offset, _Circle.xy, _Circle.w);
                    sum += calc_color(p);
                }

                return sum / sample_num;
#endif
            }

            ENDCG
        }
    }
}
