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

float   _UseMaterial2;
float   _UseMaterial3;
float   _UseMaterial4;
float   _UseMaterial5;
float4  _Color1;
float4  _Color2;
float4  _Color3;
float4  _Color4;
float4  _Color5;

float   _UseLightMapColorAO;
float   _UseVertexColorAO;

float   _LightArea;
float   _ShadowRampWidth;
float   _UseVertexRampWidth;

float   _MTMapTileScale;
float   _MTMapBrightness;
float4  _MTMapLightColor;
float4  _MTMapDarkColor;
float   _MTShininess;
float   _MTSpecularScale;
float4  _MTSpecularColor;
float   _MTSpecularAttenInShadow;
float4  _MTShadowMultiColor;

float   _UseShadowTransition;
float   _UseCoolShadowColorOrTex;

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

float4  _EmissionColor;
float   _EmissionScaler;

float   _DissolveValue;
float4  _DissolveColor;  

float4  _FakeLightDir;
CBUFFER_END

float4  mhy_AvatarLightDir;
float4  mhy_CharacterOverrideLightDir;
float4  _ES_LightDirection;
float   _ES_CharacterMainLightBrightness;
float   _ES_CharacterColorTone;
float4  _LightColor0;

float4  _AmbientSensorUVs;

TEXTURE2D(_BaseMap); SAMPLER(sampler_BaseMap);
TEXTURE2D(_LightMap); SAMPLER(sampler_LightMap);
TEXTURE2D(_MetalMap); SAMPLER(sampler_MetalMap);
TEXTURE2D(_ShadowRamp); SAMPLER(sampler_ShadowRamp);
TEXTURE2D(_AmbientSensor); SAMPLER(sampler_AmbientSensor);