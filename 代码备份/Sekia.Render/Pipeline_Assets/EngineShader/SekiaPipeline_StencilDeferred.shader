Shader "Hidden/SekiaPipeline/StencilDeferred"
{
    Properties 
    {   
        //光源覆盖区域遮罩 第5个bit
        _StencilRef ("StencilRef", Int) = 32
    }

    HLSLINCLUDE
    #pragma target 4.5
    #define _SHADOWS_SOFT
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/Shaders/Utils/Deferred.hlsl"
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
    #include "_Lib/_SharedBrdfFunctions.hlsl"

    struct a2v
    {
        float3 positionOS : POSITION;
    };

    struct v2f
    {
        float4 positionCS : SV_POSITION;
    };

    #if defined(_SPOT)
        float4 _SpotLightScale;
        float4 _SpotLightBias;
        float4 _SpotLightGuard;
    #endif

    v2f vert(a2v i)
    {
        v2f o = (v2f)0;
        float3 positionOS = i.positionOS.xyz;

        #if defined(_SPOT)
            //通过顶点偏移将切面朝负Z的半圆形转换为锥形 求半球面缩小为弧形球面 顶点变得密集
            [flatten] if (any(positionOS.xyz)) //圆点不动
            {
                positionOS.xyz = _SpotLightBias.xyz + _SpotLightScale.xyz * positionOS.xyz;
                positionOS.xyz = normalize(positionOS.xyz) * _SpotLightScale.w;
                float3 offset = float3(0.0, 0.0, _SpotLightGuard.w);
                positionOS.xyz = (positionOS.xyz - offset) * _SpotLightGuard.xyz + offset;
            }
        #endif

        #if defined(_DIRECTIONAL) || defined(_FOG)
            o.positionCS = float4(positionOS.xy, UNITY_RAW_FAR_CLIP_VALUE, 1.0);
        #else
            o.positionCS = TransformObjectToHClip(positionOS);
        #endif
        return o;
    }

    #define GBUFFER0 0
    #define GBUFFER1 1
    #define GBUFFER2 2
    #define GBUFFER3 3

    FRAMEBUFFER_INPUT_HALF(GBUFFER0);
    FRAMEBUFFER_INPUT_HALF(GBUFFER1);
    FRAMEBUFFER_INPUT_HALF(GBUFFER2);
    FRAMEBUFFER_INPUT_FLOAT(GBUFFER3);

    float4x4 _ScreenToWorld;
    float3 _LightPosWS;
    half3 _LightColor;
    half4 _LightAttenuation; //xy距离衰减 zwSpot张开角度衰减
    half3 _LightDirection;
    TEXTURE2D(_SsaoTexture);    SAMPLER(sampler_SsaoTexture);

    Light GetStencilLight(float3 positionWS, float2 screenUV)
    {
        Light light;

        bool materialReceiveShadowsOff = false;

        #if defined(_DIRECTIONAL)
            #if defined(_DEFERRED_FIRST_LIGHT)
                light = GetMainLight();
                light.distanceAttenuation = 1.0;

                #if defined(_MAIN_LIGHT_SHADOWS_SCREEN)
                    float4 shadowCoord = float4(screenUV, 0.0, 1.0);
                #elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                    float4 shadowCoord = TransformWorldToShadowCoord(positionWS.xyz);
                #else
                    float4 shadowCoord = float4(0, 0, 0, 0);
                #endif

                half shadowAttenuation = MainLightRealtimeShadow(shadowCoord);
                #if defined(MAIN_LIGHT_CALCULATE_SHADOWS) //超过最大阴影距离的地方阴影渐变
                    float3 camToPixel = positionWS - _WorldSpaceCameraPos;
                    float distanceCamToPixel2 = dot(camToPixel, camToPixel);
                    float fade = distanceCamToPixel2 * float(_MainLightShadowParams.z) + float(_MainLightShadowParams.w);
                    half shadowFade = half(saturate(fade));
                    shadowAttenuation = lerp(shadowAttenuation, 1.0h, shadowFade);
                #endif
                light.shadowAttenuation = shadowAttenuation;
                
            #else
                light.direction = _LightDirection;
                light.distanceAttenuation = 1.0;
                light.shadowAttenuation = 1.0;
                light.color = _LightColor.rgb;
            #endif
        #else
            float3 lightVector = _LightPosWS - positionWS.xyz;
            float distanceSqr = max(dot(lightVector, lightVector), HALF_MIN);
            half3 lightDirection = half3(lightVector * rsqrt(distanceSqr));
            float attenuation = DistanceAttenuation(distanceSqr, _LightAttenuation.xy) *
                AngleAttenuation(_LightDirection.xyz, lightDirection, _LightAttenuation.zw);
            light.direction = lightDirection;
            light.distanceAttenuation = attenuation;
            light.shadowAttenuation = 1.0;
            light.color = _LightColor.rgb;
        #endif
        return light;
    }

    half4 DeferredShading(v2f i) : SV_Target
    {
        float2 screenUV = i.positionCS.xy * _ScreenSize.zw;
        float rawDepth = LOAD_FRAMEBUFFER_INPUT(GBUFFER3, i.positionCS.xy).x;
        half4 gbuffer0 = LOAD_FRAMEBUFFER_INPUT(GBUFFER0, i.positionCS.xy);
        half4 gbuffer1 = LOAD_FRAMEBUFFER_INPUT(GBUFFER1, i.positionCS.xy);
        half4 gbuffer2 = LOAD_FRAMEBUFFER_INPUT(GBUFFER2, i.positionCS.xy);

        float4 positionWS = mul(_ScreenToWorld, float4(i.positionCS.xy, rawDepth, 1.0));
        positionWS.xyz *= rcp(positionWS.w);
        Light light = GetStencilLight(positionWS.xyz, screenUV);
        light.color *= light.distanceAttenuation * light.shadowAttenuation;

        half3 albedo = gbuffer0.xyz;
        half metallic = gbuffer0.w;
        half3 _EnvirLighting = gbuffer1.rgb;
        half occlusion = gbuffer1.a;
        half roughness = gbuffer2.x;
        half3 _NormalWS = SignedOctDecode(gbuffer2.yzw);
        
        #if defined(_SCREEN_SPACE_OCCLUSION)
            half ssao = SAMPLE_TEXTURE2D(_SsaoTexture, sampler_SsaoTexture, screenUV).r;
            occlusion = min(ssao, occlusion);
            light.color *= lerp(1.0h, ssao, _AmbientOcclusionParam.w);
        #endif

        //DRBF数据
        half3 _ViewDirWS = normalize(_WorldSpaceCameraPos.xyz - positionWS.xyz);
        half _NdotV = saturate(dot(_NormalWS, _ViewDirWS));
        half _PerceptualRoughness = roughness;
        half3 _Diffuse = albedo * (1.0h - metallic);
        half3 _F0 = lerp(0.04h, albedo, metallic);
        half _Roughness_a =  _PerceptualRoughness * _PerceptualRoughness;
        half _Roughness_b = _PerceptualRoughness * half(0.25) + half(0.25);

        half3 envirSpecular2 = EnvBRDFApprox(_F0, _PerceptualRoughness, _NdotV);
        half3 color = OneDirectLighting(light.color, light.direction, _NdotV, _NormalWS, 
            _ViewDirWS, _Diffuse, _F0, envirSpecular2, _Roughness_a, _Roughness_b);
        
        half alpha = 1.0h;
        #if defined(_DEFERRED_FIRST_LIGHT)
            color += _EnvirLighting * occlusion;
            color = ACESToneMapping(color);
            alpha = 0.0h;
        #endif
        return half4(color, alpha);
    }

    half4 FragFog(v2f i) : SV_Target
    {
        //类似于_FOG_FRAGMENT
        float rawDepth = LOAD_FRAMEBUFFER_INPUT(GBUFFER3, i.positionCS.xy).x;
        float eye_z = LinearEyeDepth(rawDepth, _ZBufferParams);
        float clip_z = UNITY_MATRIX_P[2][2] * -eye_z + UNITY_MATRIX_P[2][3];
        half fogFactor = ComputeFogFactor(clip_z);
        half fogIntensity = ComputeFogIntensity(fogFactor);
        return half4(unity_FogColor.rgb, fogIntensity);
    }
    ENDHLSL

    SubShader
    {
        Tags { "RenderPipeline" = "UniversalPipeline"}

        Pass
        {
            Name "Deferred Punctual Light (Lit)"
            ZTest GEqual ZWrite Off
            ZClip false Cull Front
            Blend One One
            BlendOp Add, Add
            ColorMask RGB
            Stencil { Ref [_StencilRef] ReadMask [_StencilRef] Comp Equal }

            HLSLPROGRAM
            #pragma multi_compile _POINT _SPOT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma vertex vert
            #pragma fragment DeferredShading
            ENDHLSL
        }

        Pass
        {
            Name "Deferred Directional Light (Lit)"
            ZTest NotEqual ZWrite Off
            Cull Off
            Blend One SrcAlpha
            BlendOp Add, Add
            ColorMask RGB
            Stencil { Ref [_StencilRef] ReadMask [_StencilRef] Comp Equal }

            HLSLPROGRAM
            #pragma multi_compile _DIRECTIONAL
            #pragma multi_compile_fragment _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _DEFERRED_FIRST_LIGHT
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
            #pragma multi_compile _ _TEST3
            #pragma vertex vert
            #pragma fragment DeferredShading
            ENDHLSL
        }

        Pass
        {
            Name "Fog"
            ZTest NotEqual ZWrite Off
            Cull Off
            Blend OneMinusSrcAlpha SrcAlpha
            BlendOp Add, Add
            ColorMask RGB

            HLSLPROGRAM
            #pragma multi_compile _FOG
            #pragma multi_compile FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma vertex vert
            #pragma fragment FragFog
            ENDHLSL
        }
    }
}
