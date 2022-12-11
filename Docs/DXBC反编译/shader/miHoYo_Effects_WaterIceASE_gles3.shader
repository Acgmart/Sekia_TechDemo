//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/WaterIceASE" {
Properties {
_Scale ("Scale Compared to Maya", Float) = 0.01
[Header(Element View)] _ElementViewEleID ("Element ID", Float) = 0
[MHYToggle] _ReceiveShadow ("Receive Shadow", Float) = 0
_MaterialShadowBias ("Shadow Bias", Range(0, 0.1)) = 0
_ShadowIntensity ("Shadow Intensity", Range(0, 1)) = 1
[Toggle] _EnableAlphaTest ("Enable Alpha Test", Float) = 0
_CutOff ("Mask Clip Value", Range(0, 1)) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Dithering)] [Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_CubeMap ("Cube Map", Cube) = "white" { }
_CubeMapInstensity ("Cube Map Instensity", Range(0, 10)) = 0.07
_CubeMask ("Cube Mask", 2D) = "white" { }
_CubeMaskUVscale ("Cube Mask UV scale", Range(0, 2)) = 1
_CubeMaskScaler ("Cube Mask Scaler", Range(0, 1)) = 1
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,0)
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,0)
_IceBumpTex ("IceBumpTex", 2D) = "white" { }
_AlbedoUVScale ("Albedo UV Scale", Range(0, 2)) = 0.3
_BumpOffsetHeight ("BumpOffsetHeight", Float) = 14.89
_BumpTexIntensity ("BumpTexIntensity", Range(0, 2)) = 1
_NormalTex ("Normal Tex", 2D) = "bump" { }
_NormalUVScale ("Normal UV Scale", Range(0, 2)) = 1
_NormalScale ("Normal Scale", Float) = 3
_IcePatternColor01 ("IcePatternColor01", Color) = (0.75,0.75,0.75,1)
_IcePatternColor02 ("IcePatternColor02", Color) = (0.75,0.75,0.75,1)
_IcePattern01Intensity ("IcePattern01Intensity", Range(0, 2)) = 0
_IcePatternTex ("IcePatternTex", 2D) = "white" { }
_IcePatternUVScale ("IcePatternUVScale", Range(0, 2)) = 0.3
_NoiseTex ("Noise Tex", 2D) = "white" { }
_NoiseTexUVScale01 ("NoiseTexUVScale01", Range(0, 1)) = 0.1588235
_NoiseScale01 ("NoiseScale01", Range(0, 10)) = 0.79
_NoiseTexUVScale02 ("NoiseTexUVScale02", Range(0, 10)) = 0.4411766
_NoiseScale02 ("NoiseScale02", Range(0, 10)) = 1.014169
_BorderColor01 ("BorderColor01", Color) = (0.2117647,0.8235295,0.8235295,0)
_BorderColor02 ("BorderColor02", Color) = (0.5490196,0.7960785,0.8470589,0)
_BorderNoiseThreshold01 ("BorderNoiseThreshold01", Range(0, 2)) = 1.400558
_BorderNoiseThreshold02 ("BorderNoiseThreshold02", Range(0, 1)) = 0.439
_DistanceFieldScale ("DistanceFieldScale", Range(0, 5)) = 1
_TestFrozenDegree ("TestFrozenDegree", Range(0, 1)) = 1
_ShadowDistortionScale ("ShadowDistortionScale", Float) = 0.1
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "HYBRIDDEFERRED"
  Tags { "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 41200
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _AlbedoUVScale;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	vec4 _BorderColor01;
uniform 	vec4 _BorderColor02;
uniform 	float _BorderNoiseThreshold01;
uniform 	float _BorderNoiseThreshold02;
uniform 	float _NormalScale;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _ShadowDistortionScale;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseScale02;
    u_xlat5.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat10_5 * _NoiseScale01 + u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_5 = texture(_IceSurfaceFieldMap, u_xlat5.xy).x;
    u_xlat5.x = u_xlat10_5 * _DistanceFieldScale;
    u_xlat0.x = u_xlat5.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) / _BorderNoiseThreshold01;
    u_xlat0.x = u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.x + (-_BorderNoiseThreshold02);
    u_xlat10 = (-_BorderNoiseThreshold02) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_BorderColor01.xyz) + _BorderColor02.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz + _BorderColor01.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD3.xy;
    u_xlat15 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15);
    u_xlat11.xy = vs_TEXCOORD2.xz * vec2(_AlbedoUVScale);
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat10_15 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD7.xyz;
    u_xlat2.x = vs_TEXCOORD4.x;
    u_xlat2.y = vs_TEXCOORD6.x;
    u_xlat2.z = vs_TEXCOORD5.x;
    u_xlat3.xy = vs_TEXCOORD2.xz * vec2(vec2(_NormalUVScale, _NormalUVScale));
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.xy = u_xlat16_4.xy * vec2(vec2(_ShadowDistortionScale, _ShadowDistortionScale));
    SV_Target2.xy = u_xlat16_3.xy;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapInstensity) + (-u_xlat0.xyz);
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(vec2(_CubeMaskUVscale, _CubeMaskUVscale));
    u_xlat10_15 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_4.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_4.xxx * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    SV_Target1.w = _ReceiveShadow;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.w = _ShadowIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	float _CutOff;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _AlbedoUVScale;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	vec4 _BorderColor01;
uniform 	vec4 _BorderColor02;
uniform 	float _BorderNoiseThreshold01;
uniform 	float _BorderNoiseThreshold02;
uniform 	float _NormalScale;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _ShadowDistortionScale;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat5.x = u_xlat10_5 * _NoiseScale02;
    u_xlat0.x = u_xlat10_0 * _NoiseScale01 + u_xlat5.x;
    u_xlat10.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_10 = texture(_IceSurfaceFieldMap, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 * _DistanceFieldScale;
    u_xlat0.x = u_xlat10.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat10.x * _TestFrozenDegree + (-u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) / _BorderNoiseThreshold01;
    u_xlat0.x = u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat5.x = u_xlat0.x + (-_BorderNoiseThreshold02);
    u_xlat10.x = (-_BorderNoiseThreshold02) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_BorderColor01.xyz) + _BorderColor02.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz + _BorderColor01.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD3.xy;
    u_xlat15 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15);
    u_xlat11.xy = vs_TEXCOORD2.xz * vec2(_AlbedoUVScale);
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat10_15 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD7.xyz;
    u_xlat2.x = vs_TEXCOORD4.x;
    u_xlat2.y = vs_TEXCOORD6.x;
    u_xlat2.z = vs_TEXCOORD5.x;
    u_xlat3.xy = vs_TEXCOORD2.xz * vec2(vec2(_NormalUVScale, _NormalUVScale));
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.xy = u_xlat16_4.xy * vec2(vec2(_ShadowDistortionScale, _ShadowDistortionScale));
    SV_Target2.xy = u_xlat16_3.xy;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapInstensity) + (-u_xlat0.xyz);
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(vec2(_CubeMaskUVscale, _CubeMaskUVscale));
    u_xlat10_15 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_4.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_4.xxx * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    SV_Target1.w = _ReceiveShadow;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.w = _ShadowIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat6.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _AlbedoUVScale;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	vec4 _BorderColor01;
uniform 	vec4 _BorderColor02;
uniform 	float _BorderNoiseThreshold01;
uniform 	float _BorderNoiseThreshold02;
uniform 	float _NormalScale;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _ShadowDistortionScale;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
float u_xlat10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 * _NoiseScale02;
    u_xlat5.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat0.x = u_xlat10_5 * _NoiseScale01 + u_xlat0.x;
    u_xlat5.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_5 = texture(_IceSurfaceFieldMap, u_xlat5.xy).x;
    u_xlat5.x = u_xlat10_5 * _DistanceFieldScale;
    u_xlat0.x = u_xlat5.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat0.x) / _BorderNoiseThreshold01;
    u_xlat0.x = u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat0.x + (-_BorderNoiseThreshold02);
    u_xlat10 = (-_BorderNoiseThreshold02) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_BorderColor01.xyz) + _BorderColor02.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz + _BorderColor01.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD3.xy;
    u_xlat15 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15);
    u_xlat11.xy = vs_TEXCOORD2.xz * vec2(_AlbedoUVScale);
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat10_15 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD7.xyz;
    u_xlat2.x = vs_TEXCOORD4.x;
    u_xlat2.y = vs_TEXCOORD6.x;
    u_xlat2.z = vs_TEXCOORD5.x;
    u_xlat3.xy = vs_TEXCOORD2.xz * vec2(vec2(_NormalUVScale, _NormalUVScale));
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.xy = u_xlat16_4.xy * vec2(vec2(_ShadowDistortionScale, _ShadowDistortionScale));
    SV_Target2.xy = u_xlat16_3.xy;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapInstensity) + (-u_xlat0.xyz);
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(vec2(_CubeMaskUVscale, _CubeMaskUVscale));
    u_xlat10_15 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_4.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_4.xxx * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    SV_Target1.w = _ReceiveShadow;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.w = _ShadowIntensity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat19;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat6.x * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat6.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat6.xyz;
    u_xlat6.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat6.xyz;
    vs_TEXCOORD2.xyz = u_xlat6.xyz;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xzy;
    u_xlat4.y = u_xlat3.z;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat5.y = u_xlat3.x;
    u_xlat5.x = u_xlat1.x;
    u_xlat5.z = u_xlat2.x;
    u_xlat4.xyz = u_xlat5.xyz * u_xlat0.xxx + u_xlat4.xyz;
    vs_TEXCOORD6.xyz = u_xlat3.xzy;
    u_xlat3.x = u_xlat1.z;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat3.z = u_xlat2.z;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat3.xyz * u_xlat0.zzz + u_xlat4.xyz;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	mediump float _ElementViewEleID;
uniform 	float _ReceiveShadow;
uniform 	float _ShadowIntensity;
uniform 	float _CutOff;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform 	mediump vec4 _IcePatternColor01;
uniform 	float _IcePatternUVScale;
uniform 	vec4 _IceDarkColor;
uniform 	vec4 _IceLightColor;
uniform 	float _AlbedoUVScale;
uniform 	float _BumpOffsetHeight;
uniform 	float _BumpTexIntensity;
uniform 	vec4 _BorderColor01;
uniform 	vec4 _BorderColor02;
uniform 	float _BorderNoiseThreshold01;
uniform 	float _BorderNoiseThreshold02;
uniform 	float _NormalScale;
uniform 	float _NormalUVScale;
uniform 	float _CubeMapInstensity;
uniform 	float _CubeMaskUVscale;
uniform 	float _CubeMaskScaler;
uniform 	mediump vec4 _IcePatternColor02;
uniform 	mediump float _IcePattern01Intensity;
uniform 	mediump float _ShadowDistortionScale;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _IcePatternTex;
uniform lowp sampler2D _IceBumpTex;
uniform lowp sampler2D _NormalTex;
uniform lowp samplerCube _CubeMap;
uniform lowp sampler2D _CubeMask;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
vec3 u_xlat3;
mediump vec2 u_xlat16_3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp float u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
vec2 u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat5.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_5 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat5.x = u_xlat10_5 * _NoiseScale02;
    u_xlat0.x = u_xlat10_0 * _NoiseScale01 + u_xlat5.x;
    u_xlat10.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_10 = texture(_IceSurfaceFieldMap, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 * _DistanceFieldScale;
    u_xlat0.x = u_xlat10.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat10.x * _TestFrozenDegree + (-u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) / _BorderNoiseThreshold01;
    u_xlat0.x = u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5.x<0.0);
#else
    u_xlatb5 = u_xlat5.x<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.5, 1.0, 0.5, 0.0431372561);
    u_xlat5.x = u_xlat0.x + (-_BorderNoiseThreshold02);
    u_xlat10.x = (-_BorderNoiseThreshold02) + 1.0;
    u_xlat5.x = u_xlat5.x / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_BorderColor01.xyz) + _BorderColor02.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz + _BorderColor01.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xy = vec2(u_xlat15) * vs_TEXCOORD3.xy;
    u_xlat15 = _BumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat15);
    u_xlat11.xy = vs_TEXCOORD2.xz * vec2(_AlbedoUVScale);
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001) + u_xlat11.xy;
    u_xlat10_15 = texture(_IceBumpTex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 * _BumpTexIntensity;
    u_xlat1.xyz = (-_IceDarkColor.xyz) + _IceLightColor.xyz;
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz + _IceDarkColor.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD7.xyz, vs_TEXCOORD7.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD7.xyz;
    u_xlat2.x = vs_TEXCOORD4.x;
    u_xlat2.y = vs_TEXCOORD6.x;
    u_xlat2.z = vs_TEXCOORD5.x;
    u_xlat3.xy = vs_TEXCOORD2.xz * vec2(vec2(_NormalUVScale, _NormalUVScale));
    u_xlat10_3.xyz = texture(_NormalTex, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(vec2(_NormalScale, _NormalScale));
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat2.y = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat2.z = dot(u_xlat3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.xy = u_xlat16_4.xy * vec2(vec2(_ShadowDistortionScale, _ShadowDistortionScale));
    SV_Target2.xy = u_xlat16_3.xy;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_1.xyz = texture(_CubeMap, u_xlat1.xyz).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_CubeMapInstensity) + (-u_xlat0.xyz);
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(vec2(_CubeMaskUVscale, _CubeMaskUVscale));
    u_xlat10_15 = texture(_CubeMask, u_xlat2.xy).x;
    u_xlat15 = u_xlat10_15 * _CubeMaskScaler;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _IcePatternColor02.xyz;
    u_xlat2.xy = vs_TEXCOORD2.xz * vec2(_IcePatternUVScale);
    u_xlat10_2.xy = texture(_IcePatternTex, u_xlat2.xy).xy;
    u_xlat16_4.x = u_xlat10_2.y * _IcePattern01Intensity;
    u_xlat0.xyz = u_xlat16_4.xxx * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target1.xyz = _IcePatternColor01.xyz * u_xlat10_2.xxx + u_xlat0.xyz;
    SV_Target1.w = _ReceiveShadow;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    u_xlat16_4.x = _ElementViewEleID * 0.00392156886;
    SV_Target2.z = (u_xlatb0) ? u_xlat16_4.x : 0.0;
    SV_Target2.w = _ShadowIntensity;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 110181
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = min(_MaterialShadowBias, 0.100000001);
    u_xlat0.x = (-u_xlat0.x) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat0.x / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0.x);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0.x) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _MaterialShadowBias;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = min(_MaterialShadowBias, 0.100000001);
    u_xlat0.x = (-u_xlat0.x) * 2.0 + unity_LightShadowBias.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat0.x / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat1.z;
    u_xlat3 = max((-u_xlat1.w), u_xlat0.x);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat3 = (-u_xlat0.x) + u_xlat3;
    gl_Position.z = unity_LightShadowBias.y * u_xlat3 + u_xlat0.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_1 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _NoiseScale02;
    u_xlat0.x = u_xlat10_0 * _NoiseScale01 + u_xlat1.x;
    u_xlat2.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_2 = texture(_IceSurfaceFieldMap, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _DistanceFieldScale;
    u_xlat0.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat1.x);
    u_xlat0.x = min(u_xlat1.x, u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
float u_xlat6;
void main()
{
    u_xlat0.x = min(_MaterialShadowBias, 0.100000001);
    u_xlat0.x = (-u_xlat0.x) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat0.x / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat1.z;
    u_xlat6 = max((-u_xlat1.w), u_xlat0.x);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat6 = (-u_xlat0.x) + u_xlat6;
    gl_Position.z = unity_LightShadowBias.y * u_xlat6 + u_xlat0.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _MaterialShadowBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
float u_xlat6;
void main()
{
    u_xlat0.x = min(_MaterialShadowBias, 0.100000001);
    u_xlat0.x = (-u_xlat0.x) * 2.0 + unity_LightShadowBias.x;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat0.x = u_xlat0.x / u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + u_xlat1.z;
    u_xlat6 = max((-u_xlat1.w), u_xlat0.x);
    gl_Position.xyw = u_xlat1.xyw;
    u_xlat6 = (-u_xlat0.x) + u_xlat6;
    gl_Position.z = unity_LightShadowBias.y * u_xlat6 + u_xlat0.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_1 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _NoiseScale02;
    u_xlat0.x = u_xlat10_0 * _NoiseScale01 + u_xlat1.x;
    u_xlat2.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_2 = texture(_IceSurfaceFieldMap, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _DistanceFieldScale;
    u_xlat0.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat1.x);
    u_xlat0.x = min(u_xlat1.x, u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
 Pass {
  Name "DEPTHONLY"
  Tags { "LIGHTMODE" = "DepthOnly" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 154802
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_1 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _NoiseScale02;
    u_xlat0.x = u_xlat10_0 * _NoiseScale01 + u_xlat1.x;
    u_xlat2.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_2 = texture(_IceSurfaceFieldMap, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _DistanceFieldScale;
    u_xlat0.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat1.x);
    u_xlat0.x = min(u_xlat1.x, u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    vs_TEXCOORD2.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    vs_TEXCOORD2.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _CutOff;
uniform 	float _DistanceFieldScale;
uniform 	float _TestFrozenDegree;
uniform 	float _NoiseTexUVScale01;
uniform 	float _NoiseScale01;
uniform 	float _NoiseTexUVScale02;
uniform 	float _NoiseScale02;
uniform lowp sampler2D _IceSurfaceFieldMap;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec2 u_xlat1;
lowp float u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale01, _NoiseTexUVScale01));
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD2.xz * vec2(vec2(_NoiseTexUVScale02, _NoiseTexUVScale02));
    u_xlat10_1 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat1.x = u_xlat10_1 * _NoiseScale02;
    u_xlat0.x = u_xlat10_0 * _NoiseScale01 + u_xlat1.x;
    u_xlat2.xy = vs_TEXCOORD1.xy * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat10_2 = texture(_IceSurfaceFieldMap, u_xlat2.xy).x;
    u_xlat2.x = u_xlat10_2 * _DistanceFieldScale;
    u_xlat0.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat2.x * _TestFrozenDegree + (-u_xlat1.x);
    u_xlat0.x = min(u_xlat1.x, u_xlat0.x);
    u_xlat0.x = u_xlat0.x + (-_CutOff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0 = vec4(0.0, 0.5, 0.0, 0.5);
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "gles3 " {
Keywords { "_ENABLEALPHATEST_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_ENABLEALPHATEST_ON" }
""
}
}
}
}
Fallback "Legacy Shaders/VertexLit"
CustomEditor "MiHoYoASEMaterialInspector"
}