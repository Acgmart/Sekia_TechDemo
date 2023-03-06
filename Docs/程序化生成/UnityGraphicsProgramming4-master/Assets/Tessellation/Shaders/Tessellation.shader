// Upgrade NOTE: replaced 'defined FOG_COMBINED_WITH_WORLD_POS' with 'defined (FOG_COMBINED_WITH_WORLD_POS)'

Shader "Tessellation/Tessellation"
{
    Properties
    {
        _EdgeLength ("Edge length", Range(2,50)) = 15
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _DispTex ("Disp Texture", 2D) = "black" {}
        _NormalMap ("Normalmap", 2D) = "bump" {}
        _Displacement ("Displacement", Range(0, 30.0)) = 0.3
        _Color ("Color", color) = (1,1,1,0)
        _SpecColor ("Spec color", color) = (0.5,0.5,0.5,0.5)
        _Specular ("Specular", Range(0, 1) ) = 0.078125
        _Gloss ("Gloss", Range(0, 1) ) = 0.078125
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 300
            
        Pass
        {
            CGPROGRAM
            #pragma target 4.6
            #pragma vertex vert
            #pragma fragment frag
            #pragma hull hull_shader
            #pragma domain domain_shader
            #include "UnityCG.cginc"
            #include "Tessellation.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float4 tangent : TANGENT;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };

            struct InternalTessInterp_appdata {
                float4 vertex : INTERNALTESSPOS;
                float4 tangent : TANGENT;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };

            struct TessellationFactors {
                float edge[3] : SV_TessFactor;
                float inside : SV_InsideTessFactor;
            };

            sampler2D _DispTex;
            float _Displacement;
            float _EdgeLength;
            fixed4 _SpecColor;
            float _Specular;
            float _Gloss;

            InternalTessInterp_appdata vert (appdata v) {
                InternalTessInterp_appdata o;
                o.vertex = v.vertex;
                o.tangent = v.tangent;
                o.normal = v.normal;
                o.texcoord = v.texcoord;
                return o;
            }

            float4 tessEdge (appdata v0, appdata v1, appdata v2)
            {
                return UnityEdgeLengthBasedTessCull(v0.vertex, v1.vertex, v2.vertex, _EdgeLength, _Displacement * 1.5f);
            }

            // tessellation hull constant shader
            TessellationFactors hull_const (InputPatch<InternalTessInterp_appdata, 3> v) {
                TessellationFactors o;
                float4 tf;

                tf = UnityEdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, _EdgeLength, _Displacement * 1.5f);

                o.edge[0] = tf.x;
                o.edge[1] = tf.y;
                o.edge[2] = tf.z;
                o.inside = tf.w;
                return o;
            }

            // tessellation hull shader
            [UNITY_domain("tri")]
            [UNITY_partitioning("fractional_odd")]
            [UNITY_outputtopology("triangle_cw")]
            [UNITY_patchconstantfunc("hull_const")]
            [UNITY_outputcontrolpoints(3)]
            InternalTessInterp_appdata hull_shader (InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
                return v[id];
            }

            struct v2f {
                UNITY_POSITION(pos);
                float2 uv_MainTex : TEXCOORD0; // _MainTex
                float4 tSpace0 : TEXCOORD1;
                float4 tSpace1 : TEXCOORD2;
                float4 tSpace2 : TEXCOORD3;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _NormalMap;
            fixed4 _Color;

            // vertex shader
            v2f vert_process (appdata v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f,o);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                float3 worldNormal = UnityObjectToWorldNormal(v.normal);
                fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
                fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
                fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
                o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
                o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
                o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
                return o;
            }

            void disp (inout appdata v)
            {
                float d = tex2Dlod(_DispTex, float4(v.texcoord.xy,0,0)).r * _Displacement;
                v.vertex.xyz -= v.normal * d;
            }

            // tessellation domain shader
            [UNITY_domain("tri")]
            v2f domain_shader (TessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata, 3> vi, float3 bary : SV_DomainLocation)
            {
                appdata v;
                UNITY_INITIALIZE_OUTPUT(appdata,v);
                v.vertex   = vi[0].vertex * bary.x + vi[1].vertex * bary.y + vi[2].vertex * bary.z;
                v.tangent  = vi[0].tangent * bary.x + vi[1].tangent * bary.y + vi[2].tangent * bary.z;
                v.normal   = vi[0].normal * bary.x + vi[1].normal * bary.y + vi[2].normal * bary.z;
                v.texcoord = vi[0].texcoord * bary.x + vi[1].texcoord * bary.y + vi[2].texcoord * bary.z;

                disp (v);

                v2f o = vert_process (v);
                return o;
            }

            // fragment shader
            fixed4 frag (v2f IN) : SV_Target
            {
                float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
                #ifndef USING_DIRECTIONAL_LIGHT
                    fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
                #else
                    fixed3 lightDir = _WorldSpaceLightPos0.xyz;
                #endif
                float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

                fixed3 Albedo = 0.0;
                half Emission = 0.0;
                half Specular = 0.0;
                fixed Alpha = 0.0;
                fixed Gloss = 0.0;
                fixed3 Normal = fixed3(0,0,1);

                half4 col = tex2D (_MainTex, IN.uv_MainTex) * _Color;
                Albedo = col.rgb;
                Specular = _Specular;
                Gloss = _Gloss;
                Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));

                float3 worldN;
                worldN.x = dot(IN.tSpace0.xyz, Normal);
                worldN.y = dot(IN.tSpace1.xyz, Normal);
                worldN.z = dot(IN.tSpace2.xyz, Normal);
                worldN = normalize(worldN);
                Normal = worldN;
    
                half3 h = normalize (lightDir + worldViewDir);
                fixed diff = max (0, dot (Normal, lightDir));
                float nh = max (0, dot (Normal, h));
                float spec = pow (nh, Specular*128.0) * Gloss;

                fixed4 c;
                c.rgb = Albedo * diff + _SpecColor.rgb * spec;
                c.a = col.a;

                return c;
            }
        ENDCG
        }
    }
	FallBack Off
}

