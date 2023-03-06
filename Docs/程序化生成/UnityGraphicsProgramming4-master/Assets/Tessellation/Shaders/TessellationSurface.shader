Shader "Tessellation/TessellationSurface"
{
    Properties
    {
        _EdgeLength ("Edge length", Range(2,50)) = 15
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _DispTex ("Disp Texture", 2D) = "black" {}
        _NormalMap ("Normalmap", 2D) = "bump" {}
        _Displacement ("Displacement", Range(0, 40.0)) = 0.3
        [Toggle] _Negative("Negative Displacement", Float) = 0
        _Color ("Color", color) = (1,1,1,0)
        _SpecColor ("Spec color", color) = (0.5,0.5,0.5,0.5)
        _Specular ("Specular", Range(0, 1) ) = 0.078125
        _Gloss ("Gloss", Range(0, 1) ) = 0.078125
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 300
            
        CGPROGRAM
        #pragma surface surf BlinnPhong addshadow fullforwardshadows vertex:disp tessellate:tessEdge nolightmap
        #pragma target 4.6
        #include "Tessellation.cginc"
        #pragma shader_feature _NEGATIVE_ON

        struct appdata {
            float4 vertex : POSITION;
            float4 tangent : TANGENT;
            float3 normal : NORMAL;
            float2 texcoord : TEXCOORD0;
        };

        sampler2D _DispTex;
        float _Displacement;
        float _EdgeLength;
        float _Specular;
        float _Gloss;

        float4 tessEdge (appdata v0, appdata v1, appdata v2)
        {
            //return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
            return UnityEdgeLengthBasedTessCull(v0.vertex, v1.vertex, v2.vertex, _EdgeLength, _Displacement * 1.5f);
        }

        void disp (inout appdata v)
        {
            float d = tex2Dlod(_DispTex, float4(v.texcoord.xy,0,0)).r * _Displacement;
            #ifdef _NEGATIVE_ON
                v.vertex.xyz -= v.normal * d;
            #else
                v.vertex.xyz += v.normal * d;
            #endif
        }

        struct Input {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        sampler2D _NormalMap;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Specular = _Specular;
            o.Gloss = _Gloss;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
