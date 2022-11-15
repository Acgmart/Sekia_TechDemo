#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

CBUFFER_START(UnityPerMaterial)
float4  _MainTex_ST;
float   _UseClipPlane;
float   _ClipPlaneWorld;
float4  _ClipPlane;
float   _CharacterAmbientSensorShadowOn;

float   _TextureBiasWhenDithering;
float   _MainTexAlphaUse;
float   _MainTexAlphaCutoff;

float   _FaceBlushStrength;
float4  _FaceBlushColor;

float4  _Color1;
float4  _Color2;
float4  _Color3;
float4  _Color4;
float4  _Color5;

float   _LightArea;
float   _ShadowRampWidth;

float   _MTMapTileScale;
float   _MTMapBrightness;
float4  _MTMapLightColor;
float4  _MTMapDarkColor;
float   _MTShininess;
float   _MTSpecularScale;
float4  _MTSpecularColor;
float   _MTSpecularAttenInShadow;
float4  _MTShadowMultiColor;

float   _Shininess1;
float   _Shininess2;
float   _Shininess3;
float   _Shininess4;
float   _Shininess5;
float   _SpecMulti1;
float   _SpecMulti2;
float   _SpecMulti3;
float   _SpecMulti4;
float   _SpecMulti5;
float4  _SpecularColor;
float4  _OutlineColor1;
float4  _OutlineColor2;
float4  _OutlineColor3;
float4  _OutlineColor4;
float4  _OutlineColor5;

float4  _EmissionColor;
float   _EmissionScaler;

float4  _FakeLightDir;
float   _NightIntensity;
float   _DirectLightingCof;
float   _WarmCoolCof;
float   _IsInNight;
float   _IsInCoverShader;

float4  _OutlineWidthAdjustZs;
float4  _OutlineWidthAdjustScales;
float   _OutlineWidth;
CBUFFER_END

TEXTURE2D(_BaseMap); SAMPLER(sampler_BaseMap);
TEXTURE2D(_LightMap); SAMPLER(sampler_LightMap);
TEXTURE2D(_MetalMap); SAMPLER(sampler_MetalMap);
TEXTURE2D(_ShadowRamp); SAMPLER(sampler_ShadowRamp);