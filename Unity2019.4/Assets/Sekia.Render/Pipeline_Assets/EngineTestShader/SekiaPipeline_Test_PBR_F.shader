Shader "SekiaPipeline/Test/PBR/F"
{
    Properties
    {
        [HDR]_F0("_F0", Color) = (0.04, 0.04, 0.04, 1)
        [Toggle(_TEST_IBL)]_TEST_IBL("_TEST_IBL", Int) = 0
    }

    HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

        CBUFFER_START(UnityPerMaterial)
            float4 _F0;
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
            #if defined(_TEST_IBL)
                float3 _Color = lerp(_F0.rgb, 1.0, pow(1.0 - _NdotL, 5.0));
            #else
                float3 _Color = lerp(_F0.rgb, 1.0, pow(1.0 - _VdotH, 5.0));
            #endif
            return float4(_Color, 1.0);
        }
    ENDHLSL

    SubShader
    {
        Tags{ "RenderPipeline" = "UniversalPipeline" }
        Pass
        {
            HLSLPROGRAM
                #pragma multi_compile_local _ _TEST_IBL
                #pragma vertex vert
                #pragma fragment frag
            ENDHLSL
        }
    }
}
