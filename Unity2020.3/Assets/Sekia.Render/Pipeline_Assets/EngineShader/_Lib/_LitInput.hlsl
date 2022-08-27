
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

#define _ADDITIONAL_LIGHTS
#if defined(_GBUFFER_PASS) && (defined(PLATFORM_SUPPORTS_NATIVE_RENDERPASS) || defined(SHADER_API_D3D11))
    #define _USE_RENDERPASS
#endif

CBUFFER_START(UnityPerMaterial)
half4   _BaseColor;
half    _Cutoff;
half    _MetallicCof;
half    _OcclusionCof;
half    _RoughnessCof;
half4   _EmissionColor;
CBUFFER_END

TEXTURE2D(_BaseMap); SAMPLER(sampler_BaseMap);
TEXTURE2D(_MaskMap);   SAMPLER(sampler_MaskMap);
TEXTURE2D(_NormalMap);   SAMPLER(sampler_NormalMap);
