//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Cube Volume Fog" {
Properties {
[Header(Basic)] _Color ("Color", Color) = (1,1,1,1)
_MaxThickness ("Max Thickness", Range(0, 100)) = 100
_HeightTex ("Height Tex", 2D) = "white" { }
_FlowSpeedX ("Flow Speed X", Range(-10, 10)) = 0.5
_FlowSpeedY ("Flow Speed Y", Range(-10, 10)) = 0
_Intensity ("Intensity", Range(0, 5)) = 1
[Header(Noise)] _NoiseTex ("Noise Tex", 2D) = "white" { }
_NoiseSpeedX ("Noise Speed X", Range(-10, 10)) = 0
_NoiseSpeedY ("Noise Speed Y", Range(-10, 10)) = 0.1
_NoiseIntensity ("Noise Intensity", Range(0, 1)) = 0.5
[Header(Inside And Downside)] _InsideIntensity ("Inside Intensity", Range(0, 1)) = 0.5
_DownsideIntensity ("Downside Intensity", Range(0, 1)) = 0.2
_DownsideReduction ("Downside Reduction", Range(0, 0.99)) = 0
[Header(Lighting)] _NormalFactor ("Normal Factor", Range(0, 10)) = 3
_Translucency ("Translucency", Range(0, 5)) = 0.3
_DiffuseWrap ("Diffuse Wrap", Range(0, 5)) = 0.4
[Header(Fade)] _FadeObjectEdge ("Fade Object Edge", Float) = 0
_FadeUpsideDistance ("Fade Upside Distance", Float) = 500
_FadeDownsideDistance ("Fade Downside Distance", Float) = 300
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
_FogProtectDistance ("Fog Protect Distance", Float) = 0
_FogProtectSoftness ("Fog Protect Softness", Float) = 100
[Header(Scattering)] [Toggle(RAYMARCH_MODE)] _RayMarchMode ("Ray Marching Mode", Float) = 0
_Noise3D ("Noise 3D", 3D) = "white" { }
_NoiseTiling ("Noise3D Tiling", Vector) = (1,1,1,0)
_NoiseSpeed ("Noise3D Speed", Vector) = (1,1,1,0)
_ScatterFactor ("Scatter Factor", Range(0, 100)) = 0
_AbsorptionFactor ("Absorption Factor", Range(0, 200)) = 1
_AmbientFactor ("Ambient Factor", Range(0, 100)) = 1
_Visibility ("Visibility", Range(0.1, 100)) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "DebugView" = "On" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Front
  GpuProgramID 2097
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat9 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat9 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat0.xy = (-_WorldSpaceCameraPos.xz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    vs_TEXCOORD4.w = sqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxThickness;
uniform 	mediump vec4 _HeightTex_ST;
uniform 	mediump float _FlowSpeedX;
uniform 	mediump float _FlowSpeedY;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseSpeedX;
uniform 	mediump float _NoiseSpeedY;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _InsideIntensity;
uniform 	mediump float _DownsideIntensity;
uniform 	mediump float _DownsideReduction;
uniform 	mediump float _NormalFactor;
uniform 	mediump float _Translucency;
uniform 	mediump float _DiffuseWrap;
uniform 	mediump float _FadeObjectEdge;
uniform 	mediump float _FadeUpsideDistance;
uniform 	mediump float _FadeDownsideDistance;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _HeightTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
vec2 u_xlat12;
lowp vec2 u_xlat10_12;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_16;
mediump float u_xlat16_22;
vec2 u_xlat23;
int u_xlati23;
mediump float u_xlat16_24;
mediump float u_xlat16_33;
float u_xlat34;
mediump float u_xlat16_34;
bool u_xlatb34;
float u_xlat37;
mediump float u_xlat16_38;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD5.xyz) + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD5.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xy = max(u_xlat16_0.yz, u_xlat16_0.xx);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_34 = max(u_xlat16_0.x, 0.0);
    u_xlat4.xyz = u_xlat1.xyz * vec3(u_xlat16_34) + vs_TEXCOORD5.xyz;
    u_xlat16_0.xy = min(u_xlat16_3.yz, u_xlat16_3.xx);
    u_xlat16_0.x = min(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_0.xxx + vs_TEXCOORD5.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat12.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat12.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat12.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * vs_TEXCOORD2.z;
    u_xlat1.x = u_xlat1.x / u_xlat12.x;
    u_xlat23.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat23.x = texture(_CameraDepthTexture, u_xlat23.xy).x;
    u_xlat23.x = _ZBufferParams.z * u_xlat23.x + _ZBufferParams.w;
    u_xlat23.x = float(1.0) / u_xlat23.x;
    u_xlat23.x = u_xlat23.x / u_xlat12.x;
    u_xlat16_0.x = min(abs(u_xlat23.x), u_xlat1.x);
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat1.x = u_xlat1.x / u_xlat12.x;
    u_xlat16_11 = min(abs(u_xlat23.x), u_xlat1.x);
    u_xlat16_22 = (-u_xlat1.x) + abs(u_xlat23.x);
    u_xlat16_22 = u_xlat16_22 / _FadeObjectEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_11) + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, _MaxThickness);
    u_xlat16_1.x = u_xlat16_0.x / _MaxThickness;
    u_xlat16_1.x = u_xlat16_1.x * _Intensity;
    u_xlat12.xy = u_xlat4.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat12.xy = vec2(_NoiseSpeedX, _NoiseSpeedY) * _Time.xx + u_xlat12.xy;
    u_xlat10_12.x = texture(_NoiseTex, u_xlat12.xy).x;
    u_xlat23.xy = u_xlat4.xz * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat23.xy = vec2(_FlowSpeedX, _FlowSpeedY) * _Time.xx + u_xlat23.xy;
    u_xlat12.xy = u_xlat10_12.xx * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat23.xy;
    u_xlat10_12.xy = texture(_HeightTex, u_xlat12.xy).xz;
    u_xlat16_0.x = (-u_xlat10_12.y) + u_xlat10_12.x;
    u_xlat12.x = vs_TEXCOORD5.y + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat12.x * u_xlat16_0.x + u_xlat10_12.y;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * _NormalFactor;
    u_xlat16_11 = u_xlat16_1.x + (-_DownsideReduction);
    u_xlat16_33 = (-_DownsideReduction) + 1.0;
    u_xlat16_11 = u_xlat16_11 / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_11) * _DownsideIntensity + u_xlat16_1.x;
    u_xlat16_11 = u_xlat16_11 * _DownsideIntensity;
    u_xlat16_11 = u_xlat12.x * u_xlat16_33 + u_xlat16_11;
    u_xlat16_33 = (-_InsideIntensity) + 1.0;
    u_xlat1.xz = abs(vs_TEXCOORD5.yy) + vec2(-0.649999976, -0.300000012);
    u_xlat1.xz = u_xlat1.xz * vec2(2.85714293, 6.66666651);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xz = min(max(u_xlat1.xz, 0.0), 1.0);
#else
    u_xlat1.xz = clamp(u_xlat1.xz, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat1.x * u_xlat16_33 + _InsideIntensity;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vs_TEXCOORD5.y<-0.00100000005);
#else
    u_xlatb34 = vs_TEXCOORD5.y<-0.00100000005;
#endif
    u_xlat34 = (u_xlatb34) ? 1.0 : -1.0;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz;
    u_xlat16_13.x = u_xlat34 * (-u_xlat6.y);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlat16_13.x = u_xlat16_13.x * 2.0 + -0.0199999996;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_11 * u_xlat16_33 + (-u_xlat16_13.x);
    u_xlat16_13.x = u_xlat1.x * u_xlat16_24 + u_xlat16_13.x;
    u_xlat16_1.x = (-u_xlat16_11) * u_xlat16_33 + u_xlat16_13.x;
    u_xlat1.x = u_xlat1.z * u_xlat16_1.x + u_xlat16_2.x;
    u_xlat16_11 = u_xlat16_22 * u_xlat1.x;
    u_xlat1.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.25;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat16_11 * u_xlat1.x;
    u_xlat16_11 = (-_FadeDownsideDistance) + _FadeUpsideDistance;
    u_xlat16_11 = u_xlat12.x * u_xlat16_11 + _FadeDownsideDistance;
    u_xlat23.x = (-u_xlat16_11) + vs_TEXCOORD4.w;
    u_xlat23.x = u_xlat23.x / u_xlat16_11;
    u_xlat23.x = u_xlat23.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat23.x = (-u_xlat23.x) + 1.0;
    SV_Target0.w = u_xlat23.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.y; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((0.0<u_xlat4.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.y<0.0; u_xlati23 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati23 = int((u_xlat4.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati1 = (-u_xlati1) + u_xlati23;
    u_xlat1.x = float(u_xlati1);
    u_xlat23.x = u_xlat16_0.x * u_xlat1.x + u_xlat5.y;
    u_xlat4.z = dFdy(u_xlat23.x);
    u_xlat7.x = dFdx(u_xlat23.x);
    u_xlat4.xy = dFdy(u_xlat5.zx);
    u_xlat7.yz = dFdx(u_xlat5.zx);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat7.xyz;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat7.yzx + (-u_xlat5.xyz);
    u_xlat0.w = u_xlat1.x * 0.00100000005 + u_xlat0.y;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0 = u_xlat0.xwzz * u_xlat1.xxxx;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_3.xy = (-u_xlat0.yy) * u_xlat0.xw;
    u_xlat16_3.zw = u_xlat0.wx * u_xlat0.ww;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_13.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_8.xyz;
    u_xlat3.y = (-u_xlat0.y);
    u_xlat4.xyz = u_xlat0.xyw;
    u_xlat4.w = 1.0;
    u_xlat3.xzw = u_xlat4.xzw;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_13.xyz = u_xlat16_13.xyz + u_xlat16_8.xyz;
    u_xlat16_13.xyz = max(u_xlat16_13.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xz = u_xlat0.xw * vec2(vec2(_Translucency, _Translucency));
    u_xlat16_8.y = u_xlat3.y * _Translucency;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_8.xyz = (-_WorldSpaceLightPos0.xyz) * u_xlat1.xxx + u_xlat16_8.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat16_8.x = dot(u_xlat16_8.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * _Translucency;
    u_xlat16_8.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_8.xyz;
    u_xlat16_41 = dot(u_xlat1.xzw, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_41 + _DiffuseWrap;
    u_xlat16_39 = u_xlat16_41 + 1.0;
    u_xlat16_7 = _DiffuseWrap + 1.0;
    u_xlat16_39 = u_xlat16_39 * u_xlat16_7;
    u_xlat16_38 = u_xlat16_38 / u_xlat16_39;
    u_xlat16_9.xyz = u_xlat16_8.xyz * vec3(u_xlat16_38) + u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xyz * _Color.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat0.xyw * vec3(vec3(_Translucency, _Translucency, _Translucency)) + (-u_xlat1.xzw);
    u_xlat16_41 = dot(u_xlat1.xzw, u_xlat0.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat0.ywzx * u_xlat0;
    u_xlat16_9.x = dot(u_xlat16_9.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Translucency;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_5.x = u_xlat16_41 + 1.0;
    u_xlat16_16 = u_xlat16_41 + _DiffuseWrap;
    u_xlat16_5.x = u_xlat16_7 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_16 / u_xlat16_5.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_5.xxx + u_xlat16_1.xzw;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_9.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_9.xyz;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_9.xyz * _Color.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = (-u_xlat16_13.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat12.xxx * u_xlat16_8.xyz + u_xlat16_13.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat9 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat9 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat0.xy = (-_WorldSpaceCameraPos.xz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    vs_TEXCOORD4.w = sqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxThickness;
uniform 	mediump vec4 _HeightTex_ST;
uniform 	mediump float _FlowSpeedX;
uniform 	mediump float _FlowSpeedY;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseSpeedX;
uniform 	mediump float _NoiseSpeedY;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _InsideIntensity;
uniform 	mediump float _DownsideIntensity;
uniform 	mediump float _DownsideReduction;
uniform 	mediump float _NormalFactor;
uniform 	mediump float _Translucency;
uniform 	mediump float _DiffuseWrap;
uniform 	mediump float _FadeObjectEdge;
uniform 	mediump float _FadeUpsideDistance;
uniform 	mediump float _FadeDownsideDistance;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _HeightTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
vec2 u_xlat12;
lowp vec2 u_xlat10_12;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_16;
mediump float u_xlat16_22;
vec2 u_xlat23;
int u_xlati23;
mediump float u_xlat16_24;
mediump float u_xlat16_33;
float u_xlat34;
mediump float u_xlat16_34;
bool u_xlatb34;
float u_xlat37;
mediump float u_xlat16_38;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD5.xyz) + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD5.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xy = max(u_xlat16_0.yz, u_xlat16_0.xx);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_34 = max(u_xlat16_0.x, 0.0);
    u_xlat4.xyz = u_xlat1.xyz * vec3(u_xlat16_34) + vs_TEXCOORD5.xyz;
    u_xlat16_0.xy = min(u_xlat16_3.yz, u_xlat16_3.xx);
    u_xlat16_0.x = min(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_0.xxx + vs_TEXCOORD5.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat12.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat12.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat12.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * vs_TEXCOORD2.z;
    u_xlat1.x = u_xlat1.x / u_xlat12.x;
    u_xlat23.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat23.x = texture(_CameraDepthTexture, u_xlat23.xy).x;
    u_xlat23.x = _ZBufferParams.z * u_xlat23.x + _ZBufferParams.w;
    u_xlat23.x = float(1.0) / u_xlat23.x;
    u_xlat23.x = u_xlat23.x / u_xlat12.x;
    u_xlat16_0.x = min(abs(u_xlat23.x), u_xlat1.x);
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat1.x = u_xlat1.x / u_xlat12.x;
    u_xlat16_11 = min(abs(u_xlat23.x), u_xlat1.x);
    u_xlat16_22 = (-u_xlat1.x) + abs(u_xlat23.x);
    u_xlat16_22 = u_xlat16_22 / _FadeObjectEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_11) + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, _MaxThickness);
    u_xlat16_1.x = u_xlat16_0.x / _MaxThickness;
    u_xlat16_1.x = u_xlat16_1.x * _Intensity;
    u_xlat12.xy = u_xlat4.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat12.xy = vec2(_NoiseSpeedX, _NoiseSpeedY) * _Time.xx + u_xlat12.xy;
    u_xlat10_12.x = texture(_NoiseTex, u_xlat12.xy).x;
    u_xlat23.xy = u_xlat4.xz * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat23.xy = vec2(_FlowSpeedX, _FlowSpeedY) * _Time.xx + u_xlat23.xy;
    u_xlat12.xy = u_xlat10_12.xx * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat23.xy;
    u_xlat10_12.xy = texture(_HeightTex, u_xlat12.xy).xz;
    u_xlat16_0.x = (-u_xlat10_12.y) + u_xlat10_12.x;
    u_xlat12.x = vs_TEXCOORD5.y + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat12.x * u_xlat16_0.x + u_xlat10_12.y;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * _NormalFactor;
    u_xlat16_11 = u_xlat16_1.x + (-_DownsideReduction);
    u_xlat16_33 = (-_DownsideReduction) + 1.0;
    u_xlat16_11 = u_xlat16_11 / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_11) * _DownsideIntensity + u_xlat16_1.x;
    u_xlat16_11 = u_xlat16_11 * _DownsideIntensity;
    u_xlat16_11 = u_xlat12.x * u_xlat16_33 + u_xlat16_11;
    u_xlat16_33 = (-_InsideIntensity) + 1.0;
    u_xlat1.xz = abs(vs_TEXCOORD5.yy) + vec2(-0.649999976, -0.300000012);
    u_xlat1.xz = u_xlat1.xz * vec2(2.85714293, 6.66666651);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xz = min(max(u_xlat1.xz, 0.0), 1.0);
#else
    u_xlat1.xz = clamp(u_xlat1.xz, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat1.x * u_xlat16_33 + _InsideIntensity;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vs_TEXCOORD5.y<-0.00100000005);
#else
    u_xlatb34 = vs_TEXCOORD5.y<-0.00100000005;
#endif
    u_xlat34 = (u_xlatb34) ? 1.0 : -1.0;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz;
    u_xlat16_13.x = u_xlat34 * (-u_xlat6.y);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlat16_13.x = u_xlat16_13.x * 2.0 + -0.0199999996;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_11 * u_xlat16_33 + (-u_xlat16_13.x);
    u_xlat16_13.x = u_xlat1.x * u_xlat16_24 + u_xlat16_13.x;
    u_xlat16_1.x = (-u_xlat16_11) * u_xlat16_33 + u_xlat16_13.x;
    u_xlat1.x = u_xlat1.z * u_xlat16_1.x + u_xlat16_2.x;
    u_xlat16_11 = u_xlat16_22 * u_xlat1.x;
    u_xlat1.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.25;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat16_11 * u_xlat1.x;
    u_xlat16_11 = (-_FadeDownsideDistance) + _FadeUpsideDistance;
    u_xlat16_11 = u_xlat12.x * u_xlat16_11 + _FadeDownsideDistance;
    u_xlat23.x = (-u_xlat16_11) + vs_TEXCOORD4.w;
    u_xlat23.x = u_xlat23.x / u_xlat16_11;
    u_xlat23.x = u_xlat23.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat23.x = (-u_xlat23.x) + 1.0;
    SV_Target0.w = u_xlat23.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.y; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((0.0<u_xlat4.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.y<0.0; u_xlati23 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati23 = int((u_xlat4.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati1 = (-u_xlati1) + u_xlati23;
    u_xlat1.x = float(u_xlati1);
    u_xlat23.x = u_xlat16_0.x * u_xlat1.x + u_xlat5.y;
    u_xlat4.z = dFdy(u_xlat23.x);
    u_xlat7.x = dFdx(u_xlat23.x);
    u_xlat4.xy = dFdy(u_xlat5.zx);
    u_xlat7.yz = dFdx(u_xlat5.zx);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat7.xyz;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat7.yzx + (-u_xlat5.xyz);
    u_xlat0.w = u_xlat1.x * 0.00100000005 + u_xlat0.y;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0 = u_xlat0.xwzz * u_xlat1.xxxx;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_3.xy = (-u_xlat0.yy) * u_xlat0.xw;
    u_xlat16_3.zw = u_xlat0.wx * u_xlat0.ww;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_13.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_8.xyz;
    u_xlat3.y = (-u_xlat0.y);
    u_xlat4.xyz = u_xlat0.xyw;
    u_xlat4.w = 1.0;
    u_xlat3.xzw = u_xlat4.xzw;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_13.xyz = u_xlat16_13.xyz + u_xlat16_8.xyz;
    u_xlat16_13.xyz = max(u_xlat16_13.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xz = u_xlat0.xw * vec2(vec2(_Translucency, _Translucency));
    u_xlat16_8.y = u_xlat3.y * _Translucency;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_8.xyz = (-_WorldSpaceLightPos0.xyz) * u_xlat1.xxx + u_xlat16_8.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat16_8.x = dot(u_xlat16_8.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * _Translucency;
    u_xlat16_8.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_8.xyz;
    u_xlat16_41 = dot(u_xlat1.xzw, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_41 + _DiffuseWrap;
    u_xlat16_39 = u_xlat16_41 + 1.0;
    u_xlat16_7 = _DiffuseWrap + 1.0;
    u_xlat16_39 = u_xlat16_39 * u_xlat16_7;
    u_xlat16_38 = u_xlat16_38 / u_xlat16_39;
    u_xlat16_9.xyz = u_xlat16_8.xyz * vec3(u_xlat16_38) + u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xyz * _Color.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat0.xyw * vec3(vec3(_Translucency, _Translucency, _Translucency)) + (-u_xlat1.xzw);
    u_xlat16_41 = dot(u_xlat1.xzw, u_xlat0.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat0.ywzx * u_xlat0;
    u_xlat16_9.x = dot(u_xlat16_9.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Translucency;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_5.x = u_xlat16_41 + 1.0;
    u_xlat16_16 = u_xlat16_41 + _DiffuseWrap;
    u_xlat16_5.x = u_xlat16_7 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_16 / u_xlat16_5.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_5.xxx + u_xlat16_1.xzw;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_9.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_9.xyz;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_9.xyz * _Color.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = (-u_xlat16_13.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat12.xxx * u_xlat16_8.xyz + u_xlat16_13.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat9 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat9 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat0.xy = (-_WorldSpaceCameraPos.xz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    vs_TEXCOORD4.w = sqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxThickness;
uniform 	mediump vec4 _HeightTex_ST;
uniform 	mediump float _FlowSpeedX;
uniform 	mediump float _FlowSpeedY;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseSpeedX;
uniform 	mediump float _NoiseSpeedY;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _InsideIntensity;
uniform 	mediump float _DownsideIntensity;
uniform 	mediump float _DownsideReduction;
uniform 	mediump float _NormalFactor;
uniform 	mediump float _Translucency;
uniform 	mediump float _DiffuseWrap;
uniform 	mediump float _FadeObjectEdge;
uniform 	mediump float _FadeUpsideDistance;
uniform 	mediump float _FadeDownsideDistance;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _HeightTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
vec2 u_xlat12;
lowp vec2 u_xlat10_12;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_16;
mediump float u_xlat16_22;
vec2 u_xlat23;
int u_xlati23;
mediump float u_xlat16_24;
mediump float u_xlat16_33;
float u_xlat34;
mediump float u_xlat16_34;
bool u_xlatb34;
float u_xlat37;
mediump float u_xlat16_38;
mediump float u_xlat16_39;
mediump float u_xlat16_41;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD5.xyz) + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat1.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD5.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xy = max(u_xlat16_0.yz, u_xlat16_0.xx);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_34 = max(u_xlat16_0.x, 0.0);
    u_xlat4.xyz = u_xlat1.xyz * vec3(u_xlat16_34) + vs_TEXCOORD5.xyz;
    u_xlat16_0.xy = min(u_xlat16_3.yz, u_xlat16_3.xx);
    u_xlat16_0.x = min(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_0.xxx + vs_TEXCOORD5.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat12.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat12.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat12.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * vs_TEXCOORD2.z;
    u_xlat1.x = u_xlat1.x / u_xlat12.x;
    u_xlat23.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat23.x = texture(_CameraDepthTexture, u_xlat23.xy).x;
    u_xlat23.x = _ZBufferParams.z * u_xlat23.x + _ZBufferParams.w;
    u_xlat23.x = float(1.0) / u_xlat23.x;
    u_xlat23.x = u_xlat23.x / u_xlat12.x;
    u_xlat16_0.x = min(abs(u_xlat23.x), u_xlat1.x);
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat1.x;
    u_xlat1.x = u_xlat1.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat1.x = u_xlat1.x / u_xlat12.x;
    u_xlat16_11 = min(abs(u_xlat23.x), u_xlat1.x);
    u_xlat16_22 = (-u_xlat1.x) + abs(u_xlat23.x);
    u_xlat16_22 = u_xlat16_22 / _FadeObjectEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_11) + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, _MaxThickness);
    u_xlat16_1.x = u_xlat16_0.x / _MaxThickness;
    u_xlat16_1.x = u_xlat16_1.x * _Intensity;
    u_xlat12.xy = u_xlat4.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat12.xy = vec2(_NoiseSpeedX, _NoiseSpeedY) * _Time.xx + u_xlat12.xy;
    u_xlat10_12.x = texture(_NoiseTex, u_xlat12.xy).x;
    u_xlat23.xy = u_xlat4.xz * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat23.xy = vec2(_FlowSpeedX, _FlowSpeedY) * _Time.xx + u_xlat23.xy;
    u_xlat12.xy = u_xlat10_12.xx * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat23.xy;
    u_xlat10_12.xy = texture(_HeightTex, u_xlat12.xy).xz;
    u_xlat16_0.x = (-u_xlat10_12.y) + u_xlat10_12.x;
    u_xlat12.x = vs_TEXCOORD5.y + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat12.x * u_xlat16_0.x + u_xlat10_12.y;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x * _NormalFactor;
    u_xlat16_11 = u_xlat16_1.x + (-_DownsideReduction);
    u_xlat16_33 = (-_DownsideReduction) + 1.0;
    u_xlat16_11 = u_xlat16_11 / u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_11) * _DownsideIntensity + u_xlat16_1.x;
    u_xlat16_11 = u_xlat16_11 * _DownsideIntensity;
    u_xlat16_11 = u_xlat12.x * u_xlat16_33 + u_xlat16_11;
    u_xlat16_33 = (-_InsideIntensity) + 1.0;
    u_xlat1.xz = abs(vs_TEXCOORD5.yy) + vec2(-0.649999976, -0.300000012);
    u_xlat1.xz = u_xlat1.xz * vec2(2.85714293, 6.66666651);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xz = min(max(u_xlat1.xz, 0.0), 1.0);
#else
    u_xlat1.xz = clamp(u_xlat1.xz, 0.0, 1.0);
#endif
    u_xlat16_33 = u_xlat1.x * u_xlat16_33 + _InsideIntensity;
    u_xlat16_2.x = u_xlat16_33 * u_xlat16_11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(vs_TEXCOORD5.y<-0.00100000005);
#else
    u_xlatb34 = vs_TEXCOORD5.y<-0.00100000005;
#endif
    u_xlat34 = (u_xlatb34) ? 1.0 : -1.0;
    u_xlat6.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat37 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat6.xyz = vec3(u_xlat37) * u_xlat6.xyz;
    u_xlat16_13.x = u_xlat34 * (-u_xlat6.y);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlat16_13.x = u_xlat16_13.x * 2.0 + -0.0199999996;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_11 * u_xlat16_33 + (-u_xlat16_13.x);
    u_xlat16_13.x = u_xlat1.x * u_xlat16_24 + u_xlat16_13.x;
    u_xlat16_1.x = (-u_xlat16_11) * u_xlat16_33 + u_xlat16_13.x;
    u_xlat1.x = u_xlat1.z * u_xlat16_1.x + u_xlat16_2.x;
    u_xlat16_11 = u_xlat16_22 * u_xlat1.x;
    u_xlat1.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.25;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = u_xlat16_11 * u_xlat1.x;
    u_xlat16_11 = (-_FadeDownsideDistance) + _FadeUpsideDistance;
    u_xlat16_11 = u_xlat12.x * u_xlat16_11 + _FadeDownsideDistance;
    u_xlat23.x = (-u_xlat16_11) + vs_TEXCOORD4.w;
    u_xlat23.x = u_xlat23.x / u_xlat16_11;
    u_xlat23.x = u_xlat23.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat23.x = min(max(u_xlat23.x, 0.0), 1.0);
#else
    u_xlat23.x = clamp(u_xlat23.x, 0.0, 1.0);
#endif
    u_xlat23.x = (-u_xlat23.x) + 1.0;
    SV_Target0.w = u_xlat23.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.y; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati1 = int((0.0<u_xlat4.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.y<0.0; u_xlati23 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati23 = int((u_xlat4.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati1 = (-u_xlati1) + u_xlati23;
    u_xlat1.x = float(u_xlati1);
    u_xlat23.x = u_xlat16_0.x * u_xlat1.x + u_xlat5.y;
    u_xlat4.z = dFdy(u_xlat23.x);
    u_xlat7.x = dFdx(u_xlat23.x);
    u_xlat4.xy = dFdy(u_xlat5.zx);
    u_xlat7.yz = dFdx(u_xlat5.zx);
    u_xlat5.xyz = u_xlat4.xyz * u_xlat7.xyz;
    u_xlat0.xyz = u_xlat4.zxy * u_xlat7.yzx + (-u_xlat5.xyz);
    u_xlat0.w = u_xlat1.x * 0.00100000005 + u_xlat0.y;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0 = u_xlat0.xwzz * u_xlat1.xxxx;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_3.xy = (-u_xlat0.yy) * u_xlat0.xw;
    u_xlat16_3.zw = u_xlat0.wx * u_xlat0.ww;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_13.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_8.xyz;
    u_xlat3.y = (-u_xlat0.y);
    u_xlat4.xyz = u_xlat0.xyw;
    u_xlat4.w = 1.0;
    u_xlat3.xzw = u_xlat4.xzw;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_13.xyz = u_xlat16_13.xyz + u_xlat16_8.xyz;
    u_xlat16_13.xyz = max(u_xlat16_13.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xz = u_xlat0.xw * vec2(vec2(_Translucency, _Translucency));
    u_xlat16_8.y = u_xlat3.y * _Translucency;
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat16_8.xyz = (-_WorldSpaceLightPos0.xyz) * u_xlat1.xxx + u_xlat16_8.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat16_8.x = dot(u_xlat16_8.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_8.x * u_xlat16_8.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * _Translucency;
    u_xlat16_8.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_8.xyz;
    u_xlat16_41 = dot(u_xlat1.xzw, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_41 + _DiffuseWrap;
    u_xlat16_39 = u_xlat16_41 + 1.0;
    u_xlat16_7 = _DiffuseWrap + 1.0;
    u_xlat16_39 = u_xlat16_39 * u_xlat16_7;
    u_xlat16_38 = u_xlat16_38 / u_xlat16_39;
    u_xlat16_9.xyz = u_xlat16_8.xyz * vec3(u_xlat16_38) + u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xyz * _Color.xyz + u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat0.xyw * vec3(vec3(_Translucency, _Translucency, _Translucency)) + (-u_xlat1.xzw);
    u_xlat16_41 = dot(u_xlat1.xzw, u_xlat0.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat0.ywzx * u_xlat0;
    u_xlat16_9.x = dot(u_xlat16_9.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_9.x * u_xlat16_9.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Translucency;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_8.xyz;
    u_xlat16_5.x = u_xlat16_41 + 1.0;
    u_xlat16_16 = u_xlat16_41 + _DiffuseWrap;
    u_xlat16_5.x = u_xlat16_7 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_16 / u_xlat16_5.x;
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_5.xxx + u_xlat16_1.xzw;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_9.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_9.xyz;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = u_xlat16_9.xyz * _Color.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = (-u_xlat16_13.xyz) + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat12.xxx * u_xlat16_8.xyz + u_xlat16_13.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat9 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat9 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat1.zw;
    vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat0.xy = (-_WorldSpaceCameraPos.xz) + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    vs_TEXCOORD4.w = sqrt(u_xlat0.x);
    vs_TEXCOORD4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxThickness;
uniform 	mediump vec4 _HeightTex_ST;
uniform 	mediump float _FlowSpeedX;
uniform 	mediump float _FlowSpeedY;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _NoiseTex_ST;
uniform 	mediump float _NoiseSpeedX;
uniform 	mediump float _NoiseSpeedY;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _InsideIntensity;
uniform 	mediump float _DownsideIntensity;
uniform 	mediump float _DownsideReduction;
uniform 	mediump float _NormalFactor;
uniform 	mediump float _Translucency;
uniform 	mediump float _DiffuseWrap;
uniform 	mediump float _FadeObjectEdge;
uniform 	mediump float _FadeUpsideDistance;
uniform 	mediump float _FadeDownsideDistance;
uniform 	mediump float _FogProtectDistance;
uniform 	mediump float _FogProtectSoftness;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _HeightTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
int u_xlati5;
vec4 u_xlat6;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
vec4 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_13;
vec2 u_xlat14;
mediump float u_xlat16_14;
bool u_xlatb14;
mediump float u_xlat16_16;
float u_xlat19;
mediump float u_xlat16_26;
float u_xlat27;
mediump float u_xlat16_27;
bool u_xlatb27;
mediump float u_xlat16_39;
float u_xlat40;
mediump float u_xlat16_40;
lowp float u_xlat10_40;
float u_xlat43;
mediump float u_xlat16_43;
int u_xlati43;
float u_xlat44;
bool u_xlatb44;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD5.xyz) + vec3(-0.5, -0.5, -0.5);
    u_xlat1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat40 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat40 = inversesqrt(u_xlat40);
    u_xlat1.xyz = vec3(u_xlat40) * u_xlat1.xyz;
    u_xlat16_2.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD5.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = min(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, u_xlat16_2.xyz);
    u_xlat16_0.xy = min(u_xlat16_0.yz, u_xlat16_0.xx);
    u_xlat16_0.x = min(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat4.xyz = u_xlat1.xyz * u_xlat16_0.xxx + vs_TEXCOORD5.xyz;
    u_xlat16_0.xy = max(u_xlat16_3.yz, u_xlat16_3.xx);
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_40 = max(u_xlat16_0.x, 0.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat16_40) + vs_TEXCOORD5.xyz;
    u_xlat5.xy = u_xlat1.xz * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat5.xy = vec2(_NoiseSpeedX, _NoiseSpeedY) * _Time.xx + u_xlat5.xy;
    u_xlat10_40 = texture(_NoiseTex, u_xlat5.xy).x;
    u_xlat5.xy = u_xlat1.xz * _HeightTex_ST.xy + _HeightTex_ST.zw;
    u_xlat5.xy = vec2(_FlowSpeedX, _FlowSpeedY) * _Time.xx + u_xlat5.xy;
    u_xlat5.xy = vec2(u_xlat10_40) * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat5.xy;
    u_xlat10_5.xy = texture(_HeightTex, u_xlat5.xy).xz;
    u_xlat16_0.x = (-u_xlat10_5.y) + u_xlat10_5.x;
    u_xlat40 = vs_TEXCOORD5.y + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat40 = min(max(u_xlat40, 0.0), 1.0);
#else
    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat40 * u_xlat16_0.x + u_xlat10_5.y;
    u_xlat16_13.x = u_xlat16_0.x * _NormalFactor;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat1.y; u_xlati43 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati43 = int((0.0<u_xlat1.y) ? 0xFFFFFFFFu : uint(0u));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat1.y<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
#else
    u_xlati5 = int((u_xlat1.y<0.0) ? 0xFFFFFFFFu : uint(0u));
#endif
    u_xlati43 = (-u_xlati43) + u_xlati5;
    u_xlat43 = float(u_xlati43);
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat1.x + -0.25;
    u_xlat1.x = u_xlat1.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat14.x = u_xlat16_13.x * u_xlat43 + u_xlat5.y;
    u_xlat6.z = dFdy(u_xlat14.x);
    u_xlat7.x = dFdx(u_xlat14.x);
    u_xlat6.xy = dFdy(u_xlat5.zx);
    u_xlat7.yz = dFdx(u_xlat5.zx);
    u_xlat8.xyz = u_xlat6.xyz * u_xlat7.xyz;
    u_xlat2.xyz = u_xlat6.zxy * u_xlat7.yzx + (-u_xlat8.xyz);
    u_xlat2.w = u_xlat43 * 0.00100000005 + u_xlat2.y;
    u_xlat14.x = dot(u_xlat2.xzw, u_xlat2.xzw);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat2 = u_xlat14.xxxx * u_xlat2.xwzz;
    u_xlat16_13.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_13.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_13.x);
    u_xlat16_3.xy = (-u_xlat2.yy) * u_xlat2.xw;
    u_xlat16_3.zw = u_xlat2.wx * u_xlat2.ww;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_13.xxx + u_xlat16_9.xyz;
    u_xlat6.y = (-u_xlat2.y);
    u_xlat7.xyz = u_xlat2.xyw;
    u_xlat7.w = 1.0;
    u_xlat8.xzw = u_xlat7.xzw;
    u_xlat6.xzw = u_xlat8.xzw;
    u_xlat16_9.z = dot(unity_SHAb, u_xlat6);
    u_xlat8.y = u_xlat6.y;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat8);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat6);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_9.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xz = u_xlat2.xw * vec2(vec2(_Translucency, _Translucency));
    u_xlat16_9.y = u_xlat6.y * _Translucency;
    u_xlat14.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat16_9.xyz = (-_WorldSpaceLightPos0.xyz) * u_xlat14.xxx + u_xlat16_9.xyz;
    u_xlat6.xzw = u_xlat14.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat10.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat14.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat14.x = inversesqrt(u_xlat14.x);
    u_xlat10.xyz = u_xlat14.xxx * u_xlat10.xyz;
    u_xlat16_26 = dot(u_xlat16_9.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_14 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * _Translucency;
    u_xlat16_9.xyz = _LightColor0.xyz * _Color.xyz;
    u_xlat16_11.xyz = vec3(u_xlat16_14) * u_xlat16_9.xyz;
    u_xlat8.y = u_xlat6.y;
    u_xlat16_26 = dot(u_xlat6.xzw, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_14 = u_xlat16_26 + _DiffuseWrap;
    u_xlat16_27 = u_xlat16_26 + 1.0;
    u_xlat16_43 = _DiffuseWrap + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_43;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_27;
    u_xlat16_12.xyz = u_xlat16_9.xyz * vec3(u_xlat16_14) + u_xlat16_11.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz + u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat2.xyw * vec3(vec3(_Translucency, _Translucency, _Translucency)) + (-u_xlat6.xzw);
    u_xlat16_26 = dot(u_xlat6.xzw, u_xlat2.xyw);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_39 = dot(u_xlat16_12.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_39 = min(max(u_xlat16_39, 0.0), 1.0);
#else
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
#endif
    u_xlat16_14 = u_xlat16_39 * u_xlat16_39;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_14 * _Translucency;
    u_xlat16_6.xyz = vec3(u_xlat16_14) * u_xlat16_9.xyz;
    u_xlat16_14 = u_xlat16_26 + 1.0;
    u_xlat16_27 = u_xlat16_26 + _DiffuseWrap;
    u_xlat16_14 = u_xlat16_43 * u_xlat16_14;
    u_xlat16_14 = u_xlat16_27 / u_xlat16_14;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(u_xlat16_14) + u_xlat16_6.xyz;
    u_xlat16_12.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_12.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_12.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_13.xyz = unity_SHC.xyz * u_xlat16_13.xxx + u_xlat16_12.xyz;
    u_xlat16_12.x = dot(unity_SHAr, u_xlat7);
    u_xlat16_12.y = dot(unity_SHAg, u_xlat7);
    u_xlat16_12.z = dot(unity_SHAb, u_xlat7);
    u_xlat16_13.xyz = u_xlat16_13.xyz + u_xlat16_12.xyz;
    u_xlat16_13.xyz = max(u_xlat16_13.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_13.xyz = u_xlat16_13.xyz * _Color.xyz + u_xlat16_9.xyz;
    u_xlat16_13.xyz = (-u_xlat16_3.xyz) + u_xlat16_13.xyz;
    u_xlat16_13.xyz = vec3(u_xlat40) * u_xlat16_13.xyz + u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat14.x = u_xlat6.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat14.x * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14.x));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14.x);
#endif
    u_xlat16_3.x = (u_xlatb14) ? u_xlat27 : 1.0;
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14.x = sqrt(u_xlat14.x);
    u_xlat27 = u_xlat14.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat27 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat27 = u_xlat6.y * _HeigtFogParams2.x;
    u_xlat43 = u_xlat27 * -1.44269502;
    u_xlat43 = exp2(u_xlat43);
    u_xlat43 = (-u_xlat43) + 1.0;
    u_xlat43 = u_xlat43 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_16 = (u_xlatb27) ? u_xlat43 : 1.0;
    u_xlat27 = u_xlat14.x * _HeigtFogParams2.y;
    u_xlat16_16 = u_xlat27 * u_xlat16_16;
    u_xlat16_16 = exp2((-u_xlat16_16));
    u_xlat16_3.y = (-u_xlat16_16) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat27 = u_xlat14.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat27) + 2.0;
    u_xlat16_16 = u_xlat27 * u_xlat16_16;
    u_xlat27 = u_xlat16_16 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_3.x = u_xlat27 * u_xlat16_3.x;
    u_xlat27 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat43 = (-u_xlat27) + 1.0;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat44 = dot(u_xlat6.xyz, u_xlat7.xyz);
    u_xlat6.x = dot(u_xlat6.xz, u_xlat6.xz);
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat16_3.x = (-u_xlat6.x) + _FogProtectDistance;
    u_xlat16_3.x = u_xlat16_3.x / _FogProtectSoftness;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb44 = !!((-u_xlat44)>=u_xlat6.x);
#else
    u_xlatb44 = (-u_xlat44)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat14.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat14.x = u_xlat14.x + (-_HeigtFogRamp.w);
    u_xlat14.x = u_xlat14.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat19 * u_xlat6.x;
    u_xlat19 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat44 = (u_xlatb44) ? u_xlat19 : u_xlat6.x;
    u_xlat44 = log2(u_xlat44);
    u_xlat44 = u_xlat44 * unity_FogColor.w;
    u_xlat44 = exp2(u_xlat44);
    u_xlat44 = min(u_xlat44, _HeigtFogColBase.w);
    u_xlat6.x = u_xlat5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_16 = (-u_xlat6.x) + 2.0;
    u_xlat16_16 = u_xlat16_16 * u_xlat6.x;
    u_xlat6.xyz = vec3(u_xlat16_16) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat7.xyz = (-u_xlat6.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat6.xyz = u_xlat14.xxx * u_xlat7.xyz + u_xlat6.xyz;
    u_xlat6.xyz = vec3(u_xlat44) * u_xlat6.xyz;
    u_xlat14.x = (-u_xlat44) + 1.0;
    u_xlat14.x = u_xlat43 * u_xlat14.x;
    u_xlat6.xyz = vec3(u_xlat43) * u_xlat6.xyz;
    u_xlat43 = u_xlat5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat43 = min(max(u_xlat43, 0.0), 1.0);
#else
    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
#endif
    u_xlat7.xyz = vec3(u_xlat43) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat14.xxx * u_xlat16_13.xyz + u_xlat6.xyz;
    u_xlat16_13.xyz = u_xlat16_13.xyz + (-u_xlat6.xyz);
    SV_Target0.xyz = u_xlat16_3.xxx * u_xlat16_13.xyz + u_xlat6.xyz;
    u_xlat6.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat4.xxx + u_xlat6.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat14.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat14.x;
    u_xlat14.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat14.x;
    u_xlat14.x = u_xlat14.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat27 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat27 = u_xlat27 * vs_TEXCOORD2.z;
    u_xlat14.x = u_xlat14.x / u_xlat27;
    u_xlat4.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x / u_xlat27;
    u_xlat16_13.x = min(u_xlat14.x, abs(u_xlat4.x));
    u_xlat14.x = u_xlat5.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat5.x + u_xlat14.x;
    u_xlat14.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat5.z + u_xlat14.x;
    u_xlat14.x = u_xlat14.x + hlslcc_mtx4x4unity_MatrixV[3].z;
    u_xlat14.x = u_xlat14.x / u_xlat27;
    u_xlat16_26 = min(abs(u_xlat4.x), u_xlat14.x);
    u_xlat16_39 = (-u_xlat14.x) + abs(u_xlat4.x);
    u_xlat16_39 = u_xlat16_39 / _FadeObjectEdge;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_39 = min(max(u_xlat16_39, 0.0), 1.0);
#else
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
#endif
    u_xlat16_13.x = (-u_xlat16_26) + u_xlat16_13.x;
    u_xlat16_13.x = min(u_xlat16_13.x, _MaxThickness);
    u_xlat16_14 = u_xlat16_13.x / _MaxThickness;
    u_xlat16_14 = u_xlat16_14 * _Intensity;
    u_xlat16_14 = u_xlat16_0.x * u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_14 + (-_DownsideReduction);
    u_xlat16_13.x = (-_DownsideReduction) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_13.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_13.x = (-u_xlat16_0.x) * _DownsideIntensity + u_xlat16_14;
    u_xlat16_0.x = u_xlat16_0.x * _DownsideIntensity;
    u_xlat16_0.x = u_xlat40 * u_xlat16_13.x + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vs_TEXCOORD5.y<-0.00100000005);
#else
    u_xlatb14 = vs_TEXCOORD5.y<-0.00100000005;
#endif
    u_xlat14.x = (u_xlatb14) ? 1.0 : -1.0;
    u_xlat16_13.x = u_xlat14.x * (-u_xlat10.y);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlat16_13.x = u_xlat16_13.x * 2.0 + -0.0199999996;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_26 = (-_InsideIntensity) + 1.0;
    u_xlat14.xy = abs(vs_TEXCOORD5.yy) + vec2(-0.649999976, -0.300000012);
    u_xlat14.xy = u_xlat14.xy * vec2(2.85714293, 6.66666651);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.xy = min(max(u_xlat14.xy, 0.0), 1.0);
#else
    u_xlat14.xy = clamp(u_xlat14.xy, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat14.x * u_xlat16_26 + _InsideIntensity;
    u_xlat16_3.x = u_xlat16_26 * u_xlat16_0.x;
    u_xlat16_13.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_16 = u_xlat16_0.x * u_xlat16_26 + (-u_xlat16_13.x);
    u_xlat16_13.x = u_xlat14.x * u_xlat16_16 + u_xlat16_13.x;
    u_xlat16_14 = (-u_xlat16_0.x) * u_xlat16_26 + u_xlat16_13.x;
    u_xlat14.x = u_xlat14.y * u_xlat16_14 + u_xlat16_3.x;
    u_xlat16_0.x = u_xlat16_39 * u_xlat14.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_0.x;
    u_xlat16_0.x = (-_FadeDownsideDistance) + _FadeUpsideDistance;
    u_xlat16_0.x = u_xlat40 * u_xlat16_0.x + _FadeDownsideDistance;
    u_xlat14.x = (-u_xlat16_0.x) + vs_TEXCOORD4.w;
    u_xlat14.x = u_xlat14.x / u_xlat16_0.x;
    u_xlat14.x = u_xlat14.x * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat14.x) + 1.0;
    SV_Target0.w = u_xlat14.x * u_xlat1.x;
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
Keywords { "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" }
""
}
}
}
}
}