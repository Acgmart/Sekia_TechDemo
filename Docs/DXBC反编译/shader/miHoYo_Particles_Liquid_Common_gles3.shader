//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Liquid_Common" {
Properties {
_LiquidTex ("LiquidTex", 2D) = "white" { }
_Normalmap ("Normalmap", 2D) = "bump" { }
_NormalIntensity ("NormalIntensity", Range(-1, 4)) = 1
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap ("Matcap", 2D) = "white" { }
_ColorBrightnessMax ("ColorBrightnessMax", Float) = 1.05
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 2
[MHYToggle] _MatcapAlphaToggle ("MatcapAlphaToggle", Float) = 0
_Color ("Color", Color) = (1,1,1,1)
[MHYToggle] _UspeedToggle ("UspeedToggle", Float) = 0
_Uspeed ("Uspeed", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTex[Toggle]", Float) = 0
_TextureMask ("TextureMask", 2D) = "white" { }
[Toggle(_NOISETOGGLE_ON)] _NoiseToggle ("Noise[Toggle]", Float) = 0
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
[MHYToggle] _NoiseRandomToggle ("NoiseRandomToggle", Float) = 0
_Noise_Tex ("Noise_Tex", 2D) = "white" { }
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Noise_Offset ("Noise_Offset", Float) = 0.5
_Noise_Brightness ("Noise_Brightness", Float) = 0.1
[MHYToggle] _VertexColorForLiquidColorToggle ("VertexColorForLiquidColorToggle", Float) = 0
[MHYToggle] _VertexRForLiquidOpacityToggle ("VertexRForLiquidOpacityToggle", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 1084
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
float u_xlat12;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD8.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_8 = texture(_TextureMask, u_xlat8.xy).x;
    u_xlat0.x = u_xlat10_8 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD8.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat8;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat16 = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat16 = _ZBufferParams.z * u_xlat16 + _ZBufferParams.w;
    u_xlat16 = float(1.0) / u_xlat16;
    u_xlat16 = u_xlat16 + (-vs_TEXCOORD8.w);
    u_xlat3.x = u_xlat16 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16 = u_xlat16 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat3.x * u_xlat8 + u_xlat16;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
vec2 u_xlat13;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_0 = texture(_TextureMask, u_xlat13.xy).x;
    u_xlat0.x = u_xlat10_0 * u_xlat10_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
float u_xlat12;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_8 = texture(_TextureMask, u_xlat8.xy).x;
    u_xlat0.x = u_xlat10_8 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat8;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat16 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat16 = u_xlat16 * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat3.x = u_xlat16 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16 = u_xlat16 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat3.x * u_xlat8 + u_xlat16;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
vec2 u_xlat13;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_0 = texture(_TextureMask, u_xlat13.xy).x;
    u_xlat0.x = u_xlat10_0 * u_xlat10_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * u_xlat10_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat15);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat15;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD8.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_15 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * u_xlat10_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat15);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat15;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_15 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
float u_xlat23;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
float u_xlat12;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD8.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_8 = texture(_TextureMask, u_xlat8.xy).x;
    u_xlat0.x = u_xlat10_8 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD8.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat21) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat7.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat7.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat7.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat8;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat16 = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat16 = _ZBufferParams.z * u_xlat16 + _ZBufferParams.w;
    u_xlat16 = float(1.0) / u_xlat16;
    u_xlat16 = u_xlat16 + (-vs_TEXCOORD8.w);
    u_xlat3.x = u_xlat16 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16 = u_xlat16 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat3.x * u_xlat8 + u_xlat16;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
vec2 u_xlat13;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_0 = texture(_TextureMask, u_xlat13.xy).x;
    u_xlat0.x = u_xlat10_0 * u_xlat10_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
float u_xlat23;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat9;
float u_xlat12;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat8 = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8 * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat8;
lowp float u_xlat10_8;
bvec2 u_xlatb8;
float u_xlat9;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat4.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat4.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_4.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_4.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz;
    u_xlat1.x = vs_TEXCOORD5.y;
    u_xlat1.y = vs_TEXCOORD7.y;
    u_xlat1.z = vs_TEXCOORD6.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.xy = u_xlat1.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat9 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat4.x = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat4.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat4.xx + u_xlat1.xy;
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat4.xy = u_xlat4.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat4.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_8 = texture(_TextureMask, u_xlat8.xy).x;
    u_xlat0.x = u_xlat10_8 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_UspeedToggle==1.0);
#else
    u_xlatb4 = _UspeedToggle==1.0;
#endif
    u_xlat8.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat4.x = u_xlatb4 ? u_xlat8.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat4.x + u_xlat1.y;
    u_xlat8.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat8.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_14 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = _NormalIntensity * u_xlat16_14 + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = u_xlat8.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat13) + u_xlat8.xy;
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat8.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat8.xy;
    u_xlat8.xy = u_xlat8.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat8.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat4.x + u_xlat3.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat3.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_14>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_14>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat4.x = u_xlat0.x * u_xlat10_1.w;
    u_xlatb8.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat4.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = (u_xlatb8.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat0.w = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb13 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb13)) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat21) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat7.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat7.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat7.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
float u_xlat8;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_3.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_3.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat16 = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat16 = u_xlat16 * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat3.x = u_xlat16 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16 = u_xlat16 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat3.x * u_xlat8 + u_xlat16;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
bvec2 u_xlatb3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
int u_xlati5;
vec2 u_xlat13;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_UspeedToggle==1.0);
#else
    u_xlatb0 = _UspeedToggle==1.0;
#endif
    u_xlat5.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat0.x = u_xlatb0 ? u_xlat5.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat0.x + u_xlat1.y;
    u_xlat10_5.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_2.xyz = u_xlat10_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.w + 1.0;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati5]._MeshParticleColorArray.xyz;
    u_xlat1.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_2.xyz;
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat3.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat3.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat3.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat3.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat3.x = u_xlat0.x + u_xlat3.y;
    u_xlat10_3.xy = texture(_LiquidTex, u_xlat3.xz).xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_0 = texture(_TextureMask, u_xlat13.xy).x;
    u_xlat0.x = u_xlat10_0 * u_xlat10_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_3.y;
    u_xlat16 = u_xlat0.x * u_xlat10_1.w;
    u_xlatb3.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat16 = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat16;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat0.xyz = u_xlat10_1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec3 u_xlat4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb0 = _NoiseRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat1.x = _Time.y * _Noise_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _Noise_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlat0.xy = (bool(u_xlatb0)) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat10_0.x = texture(_Noise_Tex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x + (-_Noise_Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_UspeedToggle==1.0);
#else
    u_xlatb5 = _UspeedToggle==1.0;
#endif
    u_xlat10.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat5.x = u_xlatb5 ? u_xlat10.x : float(0.0);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
    u_xlat1.x = u_xlat5.x + u_xlat1.y;
    u_xlat10.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat10.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_17 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.w + 1.0;
    u_xlat1.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati10]._MeshParticleColorArray.xyz;
    u_xlat10.x = _NormalIntensity * u_xlat16_17 + 1.0;
    u_xlat3.xyz = u_xlat10.xxx * u_xlat16_2.xyz;
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat10.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = u_xlat10.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat10.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat10.xy;
    u_xlat10.xy = u_xlat10.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat10.xy = u_xlat10.xy * vec2(0.5, 0.5);
    u_xlat10_3 = texture(_Matcap, u_xlat10.xy);
    u_xlat4.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat4.x = u_xlat5.x + u_xlat4.y;
    u_xlat0.xy = u_xlat0.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat4.xz;
    u_xlat10_0.xy = texture(_LiquidTex, u_xlat0.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_17>=u_xlat10_0.x);
#else
    u_xlatb0 = u_xlat16_17>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
    u_xlat5.x = u_xlat0.x * u_xlat10_3.w;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat10.x * u_xlat15 + u_xlat5.x;
    u_xlat0.w = u_xlat5.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb16 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb16)) ? u_xlat1.xyz : _Color.xyz;
    u_xlat1.xyz = u_xlat10_3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
float u_xlat23;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * u_xlat10_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat15);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat15;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat21) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat7.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat7.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat7.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD8.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_15 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
float u_xlat23;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat0.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec2 u_xlatb1;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat16_2 = (-vs_COLOR0.w) + 1.0;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xz).xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_2 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_7.xyz;
    u_xlat3.x = vs_TEXCOORD5.x;
    u_xlat3.y = vs_TEXCOORD7.x;
    u_xlat3.z = vs_TEXCOORD6.x;
    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = u_xlat3.xx * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * vec2(u_xlat16) + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_1 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat15 + u_xlat1.y;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xz).xy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat3.xy).x;
    u_xlat15 = u_xlat10_15 * u_xlat10_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2>=u_xlat15);
#else
    u_xlatb15 = u_xlat16_2>=u_xlat15;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_1.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat13;
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
    gl_Position.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat1.yzx * u_xlat2.zxy;
    u_xlat1.xyz = u_xlat2.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat0.zw;
    vs_TEXCOORD8.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
bvec2 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat6;
float u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
float u_xlat15;
lowp float u_xlat10_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb0.x = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat0.xyz = (u_xlatb0.x) ? vs_COLOR0.xyz : _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat1.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb15 = _NoiseRandomToggle==1.0;
#endif
    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat1.xy = (bool(u_xlatb15)) ? u_xlat1.xy : u_xlat2.xy;
    u_xlat10_15 = texture(_Noise_Tex, u_xlat1.xy).x;
    u_xlat15 = u_xlat10_15 + (-_Noise_Offset);
    u_xlat1.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(_UspeedToggle==1.0);
#else
    u_xlatb16 = _UspeedToggle==1.0;
#endif
    u_xlat2.x = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat16 = u_xlatb16 ? u_xlat2.x : float(0.0);
    u_xlat1.x = u_xlat16 + u_xlat1.y;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xyz = texture(_Normalmap, u_xlat1.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat16_8.xyz;
    u_xlat2.x = vs_TEXCOORD5.x;
    u_xlat2.y = vs_TEXCOORD7.x;
    u_xlat2.z = vs_TEXCOORD6.x;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat7 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat6.xy = vec2(u_xlat7) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat6.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat1.xx + u_xlat6.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat1.xy);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat1.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat1.x = u_xlat1.y + u_xlat16;
    u_xlat1.xy = vec2(u_xlat15) * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat1.xz;
    u_xlat10_1.xy = texture(_LiquidTex, u_xlat1.xy).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3>=u_xlat10_1.x);
#else
    u_xlatb15 = u_xlat16_3>=u_xlat10_1.x;
#endif
    u_xlat15 = (u_xlatb15) ? 0.0 : 1.0;
    u_xlat15 = u_xlat15 * u_xlat10_1.y;
    u_xlatb1.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _MatcapAlphaToggle), vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat11 = u_xlat15 * u_xlat10_2.w;
    u_xlat15 = (u_xlatb1.x) ? u_xlat11 : u_xlat15;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.x = u_xlat15 * vs_COLOR0.x;
    u_xlat15 = (u_xlatb1.y) ? u_xlat15 : u_xlat1.x;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat6.x = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6.x;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat2.xyz = u_xlat7.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat21 = u_xlat7.x * -1.44269502;
    u_xlat21 = exp2(u_xlat21);
    u_xlat21 = (-u_xlat21) + 1.0;
    u_xlat21 = u_xlat21 / u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7.x));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7.x);
#endif
    u_xlat16_3.x = (u_xlatb7) ? u_xlat21 : 1.0;
    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat21 = u_xlat7.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat21 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat21 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat21;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.00999999978<abs(u_xlat21));
#else
    u_xlatb21 = 0.00999999978<abs(u_xlat21);
#endif
    u_xlat16_10 = (u_xlatb21) ? u_xlat23 : 1.0;
    u_xlat21 = u_xlat7.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat21 = u_xlat7.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat21) + 2.0;
    u_xlat16_10 = u_xlat21 * u_xlat16_10;
    u_xlat21 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat21 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat21) + 1.0;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!((-u_xlat2.x)>=u_xlat4.x);
#else
    u_xlatb2 = (-u_xlat2.x)>=u_xlat4.x;
#endif
    u_xlat9 = u_xlat7.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x + (-_HeigtFogRamp.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat7.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat14 = u_xlat7.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat14) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat7.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat7.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat7.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat7.xyz = u_xlat7.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat7.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat4.xyz = u_xlat7.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat7.zxy + (-u_xlat4.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat1.xyz + vs_TEXCOORD3.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	vec4 _TextureMask_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform lowp sampler2D _TextureMask;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_8;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_UspeedToggle==1.0);
#else
    u_xlatb10.x = _UspeedToggle==1.0;
#endif
    u_xlat15 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat10 = u_xlatb10.x ? u_xlat15 : float(0.0);
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xz).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
    u_xlat0.xw = hlslcc_mtx4x4unity_MatrixV[2].xy * vec2(u_xlat16) + u_xlat0.xw;
    u_xlat0.xw = u_xlat0.xw * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat0.xw = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat0.xw);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat10 + u_xlat2.y;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat2.xz).xy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureMask_ST.xy + _TextureMask_ST.zw;
    u_xlat10_15 = texture(_TextureMask, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_15 * u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
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
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _VertexColorForLiquidColorToggle;
uniform 	vec4 _Color;
uniform 	mediump float _NoiseRandomToggle;
uniform 	float _Noise_Uspeed;
uniform 	vec4 _Noise_Tex_ST;
uniform 	float _Noise_Vspeed;
uniform 	float _Noise_Offset;
uniform 	float _Noise_Brightness;
uniform 	vec4 _Normalmap_ST;
uniform 	mediump float _UspeedToggle;
uniform 	float _Uspeed;
uniform 	float _NormalIntensity;
uniform 	float _MatcapSize;
uniform 	float _ColorBrightnessMax;
uniform 	vec4 _DayColor;
uniform 	mediump float _VertexRForLiquidOpacityToggle;
uniform 	mediump float _MatcapAlphaToggle;
uniform 	vec4 _LiquidTex_ST;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesLiquid_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesLiquid_Common {
	miHoYoParticlesLiquid_CommonArray_Type miHoYoParticlesLiquid_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _Noise_Tex;
uniform lowp sampler2D _Normalmap;
uniform lowp sampler2D _Matcap;
uniform lowp sampler2D _LiquidTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec2 u_xlat7;
mediump vec3 u_xlat16_8;
vec2 u_xlat10;
lowp float u_xlat10_10;
bvec2 u_xlatb10;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xyz = vs_COLOR0.xyz * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_VertexColorForLiquidColorToggle==1.0);
#else
    u_xlatb1 = _VertexColorForLiquidColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : _Color.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _Noise_Tex_ST.xy + _Noise_Tex_ST.zw;
    u_xlat2.x = _Time.y * _Noise_Uspeed + u_xlat10.x;
    u_xlat2.y = _Time.y * _Noise_Vspeed + u_xlat10.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_NoiseRandomToggle==1.0);
#else
    u_xlatb10.x = _NoiseRandomToggle==1.0;
#endif
    u_xlat12.xy = u_xlat2.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb10.x) ? u_xlat12.xy : u_xlat2.xy;
    u_xlat10_10 = texture(_Noise_Tex, u_xlat10.xy).x;
    u_xlat10.x = u_xlat10_10 + (-_Noise_Offset);
    u_xlat2.yz = vs_TEXCOORD0.xy * _Normalmap_ST.xy + _Normalmap_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_UspeedToggle==1.0);
#else
    u_xlatb15 = _UspeedToggle==1.0;
#endif
    u_xlat16 = _Time.y * _Uspeed + vs_TEXCOORD1.x;
    u_xlat15 = u_xlatb15 ? u_xlat16 : float(0.0);
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesLiquid_CommonArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat2.xy = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_2.xyz = texture(_Normalmap, u_xlat2.xy).xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = _NormalIntensity * u_xlat16_3 + 1.0;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat16_8.xyz;
    u_xlat4.x = vs_TEXCOORD5.x;
    u_xlat4.y = vs_TEXCOORD7.x;
    u_xlat4.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.y;
    u_xlat4.y = vs_TEXCOORD7.y;
    u_xlat4.z = vs_TEXCOORD6.y;
    u_xlat16 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat4.x = vs_TEXCOORD5.z;
    u_xlat4.y = vs_TEXCOORD7.z;
    u_xlat4.z = vs_TEXCOORD6.z;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat7.xy = vec2(u_xlat16) * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat7.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat0.xx + u_xlat7.xy;
    u_xlat2.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.xx + u_xlat7.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_MatcapSize, _MatcapSize)) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5);
    u_xlat10_2 = texture(_Matcap, u_xlat2.xy);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = min(u_xlat1.xyz, vec3(vec3(_ColorBrightnessMax, _ColorBrightnessMax, _ColorBrightnessMax)));
    u_xlat2.yz = vs_TEXCOORD0.xy * _LiquidTex_ST.xy + _LiquidTex_ST.zw;
    u_xlat2.x = u_xlat15 + u_xlat2.y;
    u_xlat0.xz = u_xlat10.xx * vec2(vec2(_Noise_Brightness, _Noise_Brightness)) + u_xlat2.xz;
    u_xlat10_0.xz = texture(_LiquidTex, u_xlat0.xz).xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3>=u_xlat10_0.x);
#else
    u_xlatb0.x = u_xlat16_3>=u_xlat10_0.x;
#endif
    u_xlat0.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.z;
    u_xlatb10.xy = equal(vec4(_MatcapAlphaToggle, _VertexRForLiquidOpacityToggle, _MatcapAlphaToggle, _VertexRForLiquidOpacityToggle), vec4(1.0, 1.0, 1.0, 1.0)).xy;
    u_xlat16 = u_xlat0.x * u_xlat10_2.w;
    u_xlat0.x = (u_xlatb10.x) ? u_xlat16 : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat5.x = u_xlat0.x * u_xlat5.x;
    u_xlat0.x = (u_xlatb10.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD8.xy / vs_TEXCOORD8.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD8.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_NOISETOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}