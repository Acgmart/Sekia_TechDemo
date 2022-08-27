Shader "SekiaPipeline/Test/PBR/G"
{
    Properties
    {
        _Rough("_Rough", Range(0, 1)) = 0
        [Toggle(_TEST_IBL)]_TEST_IBL("_TEST_IBL", Int) = 0
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

        float GeometrySchlickGGX(float _NdotV, float _PerceptualRoughness)
        {
            #if defined(_TEST_IBL)
                float r = _PerceptualRoughness;
                float k = r * r / 2.0;
            #else
                float r = _PerceptualRoughness + 1.0;
                float k = r * r / 8.0;
            #endif
            float denominator = k + (1.0 - k) * _NdotV;
            return _NdotV / max(denominator, 0.0000001);
        }

        float G_GeometrySmith(float _NdotL, float _NdotV, float _PerceptualRoughness)
        {
            float ggx1 = GeometrySchlickGGX(_NdotV, _PerceptualRoughness);
            float ggx2 = GeometrySchlickGGX(_NdotL, _PerceptualRoughness);
            return ggx1 * ggx2;
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
            float3 _Color = G_GeometrySmith(_NdotL, _NdotV, _Rough);
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
