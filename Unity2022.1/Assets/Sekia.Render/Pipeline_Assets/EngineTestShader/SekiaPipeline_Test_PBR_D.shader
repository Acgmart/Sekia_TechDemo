Shader "SekiaPipeline/Test/PBR/D"
{
    Properties
    {
        _Rough("_Rough", Range(0, 1)) = 0
    }

    HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

        CBUFFER_START(UnityPerMaterial)
            float _Rough;
        CBUFFER_END

        struct a2v
        {
            float3 positionOS       : POSITION;
            float3 normalOS          : NORMAL;
        };

        struct v2f
        {
            float4 positionCS           : SV_POSITION;
            float3 positionWS           : TEXCOORD0;
            float3 normalWS             : TEXCOORD1;
        };

        half D_GGX_NoPi(half _NdotH, half a2)
        {
            half d = _NdotH * _NdotH * (a2 - 1) + 1.0001h;
            return a2 / (d * d);
        }

        v2f vert(a2v i)
        {
            v2f o = (v2f)0;
            o.positionWS = TransformObjectToWorld(i.positionOS);
            o.positionCS = TransformWorldToHClip(o.positionWS);
            o.normalWS = TransformObjectToWorldNormal(i.normalOS, false);
            return o;
        }

        float4 frag(v2f i) : SV_Target
        {
            float3 _NormalWS = normalize(i.normalWS);
            float3 _ViewDir = normalize(_WorldSpaceCameraPos.xyz - i.positionWS);
            float3 _LightDir = _MainLightPosition.xyz;
            float3 _HalfDir = normalize(_LightDir + _ViewDir);
            float _LdotH = saturate(dot(_LightDir, _HalfDir));
            float _VdotH = saturate(dot(_ViewDir, _HalfDir));
            float _NdotL = saturate(dot(_NormalWS, _LightDir));
            float _NdotV = saturate(dot(_NormalWS, _ViewDir));
            float _NdotH = saturate(dot(_NormalWS, _HalfDir));
            float a = _Rough * _Rough;
            float a2 = a * a;
            float3 _Color = D_GGX_NoPi(_NdotH, a2);
            return float4(_Color, 1.0);
        }
    ENDHLSL

    SubShader
    {
        Tags{ "RenderPipeline" = "UniversalPipeline" }
        Pass
        {
            HLSLPROGRAM
                #pragma vertex vert
                #pragma fragment frag
            ENDHLSL
        }
    }
}
