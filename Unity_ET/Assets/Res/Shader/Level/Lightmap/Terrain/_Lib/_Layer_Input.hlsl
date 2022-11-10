#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Assets/Res/Shader/_SharedLib/_SharedBrdfFunctions.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _Tiling;
half4 _SmoothnessCof;
CBUFFER_END

TEXTURE2D(_Control); SAMPLER(sampler_Control);
TEXTURE2D(_Splat1);  SAMPLER(sampler_Splat1);  
TEXTURE2D(_Splat2);  
TEXTURE2D(_NormalMap1);	SAMPLER(sampler_NormalMap1);
TEXTURE2D(_NormalMap2);
TEXTURE2D(_Splat3);
TEXTURE2D(_NormalMap3);
TEXTURE2D(_Splat4);
TEXTURE2D(_NormalMap4);