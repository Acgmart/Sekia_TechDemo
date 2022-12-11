//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Grass/Transparent/Cutout/MeshPlant" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(PLANTS_WIND)] _PlantsWind ("Enable Wind for Plants", Float) = 0
_WindStrength ("Wind Strength", Range(0, 1)) = 0.2
_WindFrenquency ("Wind Frequency", Range(0, 10)) = 0.1
_WindWaveLength ("Wind Wave Length", Range(0.1, 50)) = 10
_WindBend ("Wind Bend", Range(0, 1)) = 0
_WindPhaseDivergence ("Wind Phase Variance", Range(0, 2)) = 1
[Toggle(PLANTS_INTERACTION)] _PlantsInteraction ("Enable Interaction", Float) = 0
_DisplacementParam ("Interaction Parameter", Vector) = (0.1,0.1,0.1,0.2)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
  Cull Off
  GpuProgramID 5530
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
float u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	float _Cutoff;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_TARGET0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat9 = u_xlat10_0.w + (-_Cutoff);
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if((int(u_xlatb9) * int(0xffffffffu))!=0){discard;}
    u_xlat9 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * vs_TEXCOORD0.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_2);
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    SV_TARGET0.xyz = u_xlat0.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "HYBRIDDEFERRED"
  LOD 200
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "HYBRIDDEFERRED" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 115765
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat7;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xy = u_xlat0.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xy = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.y / _GrassDisplacementArea.w);
    u_xlat1.xyz = textureLod(_GrassDisplacementTex, u_xlat1.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * in_COLOR0.y;
    u_xlat9 = u_xlat9 * _DisplacementParam.y;
    u_xlat7 = max(u_xlat1.z, _DisplacementParam.z);
    u_xlat1.xy = u_xlat1.xy * in_COLOR0.yy;
    u_xlat1.xy = u_xlat1.xy * _DisplacementParam.xx;
    u_xlat7 = min(u_xlat7, _DisplacementParam.w);
    u_xlat2.y = (-u_xlat9) * u_xlat7;
    u_xlat9 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat2.xz = u_xlat1.xy * vec2(0.75, 0.75);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat4.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
    u_xlat2.xy = u_xlat4.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat14 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.w = sqrt(u_xlat14);
    u_xlat2.xyw = u_xlat2.xyw * in_COLOR0.yyy;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xyw = u_xlat2.xyw * _DisplacementParam.xxy;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = u_xlat10 * (-u_xlat2.w);
    u_xlat10 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat7;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xy = u_xlat0.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xy = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.y / _GrassDisplacementArea.w);
    u_xlat1.xyz = textureLod(_GrassDisplacementTex, u_xlat1.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * in_COLOR0.y;
    u_xlat9 = u_xlat9 * _DisplacementParam.y;
    u_xlat7 = max(u_xlat1.z, _DisplacementParam.z);
    u_xlat1.xy = u_xlat1.xy * in_COLOR0.yy;
    u_xlat1.xy = u_xlat1.xy * _DisplacementParam.xx;
    u_xlat7 = min(u_xlat7, _DisplacementParam.w);
    u_xlat2.y = (-u_xlat9) * u_xlat7;
    u_xlat9 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat2.xz = u_xlat1.xy * vec2(0.75, 0.75);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat4.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
    u_xlat2.xy = u_xlat4.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat14 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.w = sqrt(u_xlat14);
    u_xlat2.xyw = u_xlat2.xyw * in_COLOR0.yyy;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xyw = u_xlat2.xyw * _DisplacementParam.xxy;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = u_xlat10 * (-u_xlat2.w);
    u_xlat10 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat1.x = u_xlat10_0.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD0.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * _SpecColor.xyz;
    SV_Target1.xyz = u_xlat0.xyz;
    SV_Target1.w = 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
    SV_Target2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.z;
    SV_Target2.xy = u_xlat16_2.xy;
    SV_Target2.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat7;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xy = u_xlat0.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xy = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.y / _GrassDisplacementArea.w);
    u_xlat1.xyz = textureLod(_GrassDisplacementTex, u_xlat1.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * in_COLOR0.y;
    u_xlat9 = u_xlat9 * _DisplacementParam.y;
    u_xlat7 = max(u_xlat1.z, _DisplacementParam.z);
    u_xlat1.xy = u_xlat1.xy * in_COLOR0.yy;
    u_xlat1.xy = u_xlat1.xy * _DisplacementParam.xx;
    u_xlat7 = min(u_xlat7, _DisplacementParam.w);
    u_xlat2.y = (-u_xlat9) * u_xlat7;
    u_xlat9 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat2.xz = u_xlat1.xy * vec2(0.75, 0.75);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat4.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
    u_xlat2.xy = u_xlat4.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat14 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.w = sqrt(u_xlat14);
    u_xlat2.xyw = u_xlat2.xyw * in_COLOR0.yyy;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xyw = u_xlat2.xyw * _DisplacementParam.xxy;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = u_xlat10 * (-u_xlat2.w);
    u_xlat10 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ScreenParams;
uniform 	float _Cutoff;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump float _ElementViewEleDrawOn;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _LODIndex;
uniform 	float _DebugTexelDensityScreenSize;
uniform 	float _DebugTexelDensityViewMode;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Color;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
vec3 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
vec4 u_xlat4;
bool u_xlatb4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
mediump vec4 u_xlat16_6;
vec4 u_xlat7;
bvec2 u_xlatb7;
vec3 u_xlat8;
bvec4 u_xlatb8;
vec3 u_xlat9;
vec3 u_xlat10;
int u_xlati11;
bvec3 u_xlatb11;
bool u_xlatb14;
vec3 u_xlat15;
int u_xlati15;
bvec2 u_xlatb15;
float u_xlat17;
vec3 u_xlat18;
vec3 u_xlat19;
int u_xlati22;
bool u_xlatb22;
vec2 u_xlat26;
int u_xlati26;
bvec2 u_xlatb26;
vec2 u_xlat28;
vec2 u_xlat29;
float u_xlat30;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat37;
float u_xlat39;
float u_xlat40;
float u_xlat41;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_DebugViewInfo.x==5.0);
#else
    u_xlatb0 = unity_DebugViewInfo.x==5.0;
#endif
    u_xlatb11.xyz = lessThan(vec4(2.9000001, 1.89999998, 0.899999976, 0.899999976), vec4(_LODIndex)).xyz;
    u_xlat1 = (u_xlatb11.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    u_xlat1 = (u_xlatb11.y) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat1;
    u_xlat1 = (u_xlatb11.x) ? vec4(0.0, 1.0, 0.0, 1.0) : u_xlat1;
    if(!u_xlatb0){
#ifdef UNITY_ADRENO_ES3
        u_xlatb11.x = !!(unity_DebugViewInfo.x==6.0);
#else
        u_xlatb11.x = unity_DebugViewInfo.x==6.0;
#endif
        u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
        u_xlat16_2.xyz = (u_xlatb11.x) ? u_xlat2.xyz : u_xlat1.xyz;
        u_xlat16_2.w = 1.0;
        if(!u_xlatb11.x){
#ifdef UNITY_ADRENO_ES3
            u_xlatb22 = !!(unity_DebugViewInfo.x==7.0);
#else
            u_xlatb22 = unity_DebugViewInfo.x==7.0;
#endif
            u_xlat33 = max(_MainTex_TexelSize.w, _MainTex_TexelSize.z);
            u_xlat3.x = max(u_xlat33, 8.0);
#ifdef UNITY_ADRENO_ES3
            u_xlatb14 = !!(256.0<u_xlat3.x);
#else
            u_xlatb14 = 256.0<u_xlat3.x;
#endif
            u_xlatb3.xz = greaterThanEqual(vec4(512.0, 0.0, 1024.0, 0.0), u_xlat3.xxxx).xz;
            u_xlat4 = (u_xlatb3.z) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
            u_xlat4 = (u_xlatb3.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat4;
            u_xlat3 = (bool(u_xlatb14)) ? u_xlat4 : vec4(0.0, 1.0, 0.0, 1.0);
            u_xlat16_3 = (bool(u_xlatb22)) ? u_xlat3 : u_xlat16_2;
            if(!u_xlatb22){
#ifdef UNITY_ADRENO_ES3
                u_xlatb4 = !!(unity_DebugViewInfo.x==8.0);
#else
                u_xlatb4 = unity_DebugViewInfo.x==8.0;
#endif
                u_xlat15.xy = vec2(vs_TEXCOORD1.x * _MainTex_TexelSize.z, vs_TEXCOORD1.y * _MainTex_TexelSize.w);
                u_xlat5.xy = dFdx(u_xlat15.xy);
                u_xlat15.xy = dFdy(u_xlat15.xy);
                u_xlat37 = dot(u_xlat5.xy, u_xlat5.xy);
                u_xlat15.x = dot(u_xlat15.xy, u_xlat15.xy);
                u_xlat15.x = max(u_xlat15.x, u_xlat37);
                u_xlat15.x = log2(u_xlat15.x);
                u_xlat15.x = u_xlat15.x * 0.5;
                u_xlat15.x = max(u_xlat15.x, 0.0);
                u_xlat15.x = u_xlat15.x + 1.0;
                u_xlat33 = u_xlat33 / u_xlat15.x;
#ifdef UNITY_ADRENO_ES3
                u_xlatb15.x = !!(256.0<u_xlat33);
#else
                u_xlatb15.x = 256.0<u_xlat33;
#endif
                u_xlatb26.xy = greaterThanEqual(vec4(512.0, 1024.0, 512.0, 1024.0), vec4(u_xlat33)).xy;
                u_xlat5 = (u_xlatb26.y) ? vec4(1.0, 0.0, 0.0, 1.0) : vec4(0.0, 0.0, 1.0, 1.0);
                u_xlat5 = (u_xlatb26.x) ? vec4(1.0, 1.0, 0.0, 1.0) : u_xlat5;
                u_xlat5 = (u_xlatb15.x) ? u_xlat5 : vec4(0.0, 1.0, 0.0, 1.0);
                u_xlat16_5 = (bool(u_xlatb4)) ? u_xlat5 : u_xlat16_3;
                if(!u_xlatb4){
                    u_xlat6.zw = vec2(vs_TEXCOORD1.x + (-_MainTex_ST.z), vs_TEXCOORD1.y + (-_MainTex_ST.w));
                    u_xlat15.xy = vec2(_MainTex_ST.x * _MainTex_TexelSize.z, _MainTex_ST.y * _MainTex_TexelSize.w);
                    u_xlatb15.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat15.xyxx).xy;
                    u_xlatb33 = u_xlatb15.y || u_xlatb15.x;
                    u_xlat6.xy = _MainTex_TexelSize.zw;
                    u_xlat6 = (bool(u_xlatb33)) ? u_xlat6 : vec4(1.0, 1.0, 0.0, 0.0);
#ifdef UNITY_ADRENO_ES3
                    u_xlatb33 = !!(unity_DebugViewInfo.x==51.0);
#else
                    u_xlatb33 = unity_DebugViewInfo.x==51.0;
#endif
#ifdef UNITY_ADRENO_ES3
                    u_xlatb15.x = !!(_DebugTexelDensityViewMode<0.5);
#else
                    u_xlatb15.x = _DebugTexelDensityViewMode<0.5;
#endif
                    if(u_xlatb15.x){
                        u_xlat15.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                        u_xlat7.xy = dFdx(u_xlat15.xy);
                        u_xlat15.xy = dFdy(u_xlat15.xy);
                        u_xlat37 = dot(u_xlat7.xy, u_xlat7.xy);
                        u_xlat29.x = dot(u_xlat15.xy, u_xlat15.xy);
                        u_xlat37 = max(u_xlat37, u_xlat29.x);
                        u_xlat37 = log2(u_xlat37);
                        u_xlat37 = u_xlat37 * 0.5;
                        u_xlat37 = max(u_xlat37, 0.0);
                        u_xlat37 = u_xlat37 + 1.0;
                        u_xlat29.x = _ScreenParams.x / _DebugTexelDensityScreenSize;
                        u_xlat7.xy = u_xlat29.xx * u_xlat7.xy;
                        u_xlat15.xy = u_xlat15.xy * u_xlat29.xx;
                        u_xlat7.xy = u_xlat7.xy / vec2(u_xlat37);
                        u_xlat15.xy = u_xlat15.xy / vec2(u_xlat37);
                        u_xlat26.y = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                        u_xlat26.x = dot(abs(u_xlat15.xy), abs(u_xlat15.xy));
                        u_xlat18.xy = sqrt(u_xlat26.yx);
                        u_xlat37 = inversesqrt(u_xlat26.y);
                        u_xlat37 = u_xlat37 * abs(u_xlat7.x);
                        u_xlat26.x = inversesqrt(u_xlat26.x);
                        u_xlat15.x = u_xlat26.x * abs(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x * u_xlat37;
                        u_xlat15.x = (-u_xlat15.x) * u_xlat15.x + 1.0;
                        u_xlat15.x = sqrt(u_xlat15.x);
                        u_xlat26.x = u_xlat18.y * u_xlat18.x;
                        u_xlat37 = u_xlat15.x * u_xlat26.x;
                        u_xlat7.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                        u_xlat29.x = fract((-u_xlat7.x));
                        u_xlat7.z = u_xlat29.x + 0.5;
                        u_xlat7.xy = fract(u_xlat7.xy);
                        u_xlat7.xy = u_xlat7.xy + vec2(0.5, 0.5);
                        u_xlat7.xyz = floor(u_xlat7.xyz);
                        u_xlat29.x = (-u_xlat7.x) + u_xlat7.z;
                        u_xlat7.x = u_xlat29.x * u_xlat7.y + u_xlat7.x;
                        u_xlat18.x = (-u_xlat26.x) * u_xlat15.x + 1.0;
                        u_xlat8.xyz = (-u_xlat7.xxx) + vec3(0.5, 0.0, 1.0);
                        u_xlat18.xyz = u_xlat18.xxx * u_xlat8.xyz + u_xlat7.xxx;
                        u_xlatb8.xw = lessThan(vec4(u_xlat37), vec4(1.0, 0.0, 0.0, 2.0)).xw;
                        u_xlat9.xyz = u_xlat7.xxx * vec3(0.0, 1.0, 0.0);
                        u_xlat15.x = u_xlat26.x * u_xlat15.x + -4.0;
                        u_xlat15.x = exp2(u_xlat15.x);
                        u_xlat15.x = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                        u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
                        u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
                        u_xlat15.xyz = u_xlat15.xxx * u_xlat8.zyy + u_xlat7.xxx;
                        u_xlat15.xyz = (u_xlatb8.w) ? u_xlat9.xyz : u_xlat15.xyz;
                        u_xlat15.xyz = (u_xlatb8.x) ? u_xlat18.xyz : u_xlat15.xyz;
                    } else {
#ifdef UNITY_ADRENO_ES3
                        u_xlatb7.x = !!(_DebugTexelDensityViewMode<1.5);
#else
                        u_xlatb7.x = _DebugTexelDensityViewMode<1.5;
#endif
                        if(u_xlatb7.x){
                            u_xlat7 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                            u_xlat8.xy = dFdx(u_xlat7.xy);
                            u_xlat7.xy = dFdy(u_xlat7.xy);
                            u_xlat30 = dot(u_xlat8.xy, u_xlat8.xy);
                            u_xlat41 = dot(u_xlat7.xy, u_xlat7.xy);
                            u_xlat30 = max(u_xlat41, u_xlat30);
                            u_xlat30 = log2(u_xlat30);
                            u_xlat30 = u_xlat30 * 0.5;
                            u_xlat30 = max(u_xlat30, 0.0);
                            u_xlat30 = u_xlat30 + 1.0;
                            u_xlat41 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                            u_xlat8.xy = vec2(u_xlat41) * u_xlat8.xy;
                            u_xlat7.xy = u_xlat7.xy * vec2(u_xlat41);
                            u_xlat8.xy = u_xlat8.xy / vec2(u_xlat30);
                            u_xlat7.xy = u_xlat7.xy / vec2(u_xlat30);
                            u_xlat19.x = dot(abs(u_xlat8.xy), abs(u_xlat8.xy));
                            u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                            u_xlat30 = sqrt(u_xlat19.x);
                            u_xlat41 = sqrt(u_xlat18.x);
                            u_xlat19.x = inversesqrt(u_xlat19.x);
                            u_xlat8.x = u_xlat19.x * abs(u_xlat8.x);
                            u_xlat18.x = inversesqrt(u_xlat18.x);
                            u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x * u_xlat8.x;
                            u_xlat7.x = (-u_xlat7.x) * u_xlat7.x + 1.0;
                            u_xlat7.x = sqrt(u_xlat7.x);
                            u_xlat18.x = u_xlat41 * u_xlat30;
                            u_xlat8.x = u_xlat7.x * u_xlat18.x;
                            u_xlat19.x = fract((-u_xlat7.z));
                            u_xlat19.x = u_xlat19.x + 0.5;
                            u_xlat19.x = floor(u_xlat19.x);
                            u_xlat29.xy = fract(u_xlat7.zw);
                            u_xlat29.xy = u_xlat29.xy + vec2(0.5, 0.5);
                            u_xlat29.xy = floor(u_xlat29.xy);
                            u_xlat19.x = (-u_xlat29.x) + u_xlat19.x;
                            u_xlat29.x = u_xlat19.x * u_xlat29.y + u_xlat29.x;
                            u_xlat40 = (-u_xlat18.x) * u_xlat7.x + 1.0;
                            u_xlat19.xyz = (-u_xlat29.xxx) + vec3(0.5, 0.0, 1.0);
                            u_xlat9.xyz = vec3(u_xlat40) * u_xlat19.xyz + u_xlat29.xxx;
                            u_xlatb8.xy = lessThan(u_xlat8.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                            u_xlat10.xyz = u_xlat29.xxx * vec3(0.0, 1.0, 0.0);
                            u_xlat7.x = u_xlat18.x * u_xlat7.x + -4.0;
                            u_xlat7.x = exp2(u_xlat7.x);
                            u_xlat7.x = u_xlat7.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                            u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
                            u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
                            u_xlat7.xyz = u_xlat7.xxx * u_xlat19.zyy + u_xlat29.xxx;
                            u_xlat7.xyz = (u_xlatb8.y) ? u_xlat10.xyz : u_xlat7.xyz;
                            u_xlat15.xyz = (u_xlatb8.x) ? u_xlat9.xyz : u_xlat7.xyz;
                        } else {
#ifdef UNITY_ADRENO_ES3
                            u_xlatb7.x = !!(u_xlat6.x>=4096.0);
#else
                            u_xlatb7.x = u_xlat6.x>=4096.0;
#endif
                            if(u_xlatb7.x){
                                u_xlat6.xy = vec2(u_xlat6.x * u_xlat6.z, u_xlat6.y * u_xlat6.w);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat28.xy = vec2(u_xlat6.z * float(3.0), u_xlat6.w * float(3.0));
                                u_xlat18.x = fract((-u_xlat28.x));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat28.xy);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            } else {
                                u_xlat6 = vs_TEXCOORD1.xyxy * vec4(4096.0, 4096.0, 3.0, 3.0);
                                u_xlat7.xy = dFdx(u_xlat6.xy);
                                u_xlat6.xy = dFdy(u_xlat6.xy);
                                u_xlat29.x = dot(u_xlat7.xy, u_xlat7.xy);
                                u_xlat40 = dot(u_xlat6.xy, u_xlat6.xy);
                                u_xlat29.x = max(u_xlat40, u_xlat29.x);
                                u_xlat29.x = log2(u_xlat29.x);
                                u_xlat29.x = u_xlat29.x * 0.5;
                                u_xlat29.x = max(u_xlat29.x, 0.0);
                                u_xlat29.x = u_xlat29.x + 1.0;
                                u_xlat40 = _ScreenParams.x / _DebugTexelDensityScreenSize;
                                u_xlat7.xy = vec2(u_xlat40) * u_xlat7.xy;
                                u_xlat6.xy = u_xlat6.xy * vec2(u_xlat40);
                                u_xlat7.xy = u_xlat7.xy / u_xlat29.xx;
                                u_xlat6.xy = u_xlat6.xy / u_xlat29.xx;
                                u_xlat18.x = dot(abs(u_xlat7.xy), abs(u_xlat7.xy));
                                u_xlat17 = dot(abs(u_xlat6.xy), abs(u_xlat6.xy));
                                u_xlat29.x = sqrt(u_xlat18.x);
                                u_xlat40 = sqrt(u_xlat17);
                                u_xlat18.x = inversesqrt(u_xlat18.x);
                                u_xlat7.x = u_xlat18.x * abs(u_xlat7.x);
                                u_xlat17 = inversesqrt(u_xlat17);
                                u_xlat6.x = u_xlat17 * abs(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x * u_xlat7.x;
                                u_xlat6.x = (-u_xlat6.x) * u_xlat6.x + 1.0;
                                u_xlat6.x = sqrt(u_xlat6.x);
                                u_xlat17 = u_xlat40 * u_xlat29.x;
                                u_xlat7.x = u_xlat6.x * u_xlat17;
                                u_xlat18.x = fract((-u_xlat6.z));
                                u_xlat18.x = u_xlat18.x + 0.5;
                                u_xlat18.x = floor(u_xlat18.x);
                                u_xlat28.xy = fract(u_xlat6.zw);
                                u_xlat28.xy = u_xlat28.xy + vec2(0.5, 0.5);
                                u_xlat28.xy = floor(u_xlat28.xy);
                                u_xlat18.x = (-u_xlat28.x) + u_xlat18.x;
                                u_xlat28.x = u_xlat18.x * u_xlat28.y + u_xlat28.x;
                                u_xlat39 = (-u_xlat17) * u_xlat6.x + 1.0;
                                u_xlat18.xyz = (-u_xlat28.xxx) + vec3(0.5, 0.0, 1.0);
                                u_xlat8.xyz = vec3(u_xlat39) * u_xlat18.xyz + u_xlat28.xxx;
                                u_xlatb7.xy = lessThan(u_xlat7.xxxx, vec4(1.0, 2.0, 0.0, 0.0)).xy;
                                u_xlat9.xyz = u_xlat28.xxx * vec3(0.0, 1.0, 0.0);
                                u_xlat6.x = u_xlat17 * u_xlat6.x + -4.0;
                                u_xlat6.x = exp2(u_xlat6.x);
                                u_xlat6.x = u_xlat6.x + -0.25;
#ifdef UNITY_ADRENO_ES3
                                u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
                                u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
                                u_xlat6.xyz = u_xlat6.xxx * u_xlat18.zyy + u_xlat28.xxx;
                                u_xlat6.xyz = (u_xlatb7.y) ? u_xlat9.xyz : u_xlat6.xyz;
                                u_xlat15.xyz = (u_xlatb7.x) ? u_xlat8.xyz : u_xlat6.xyz;
                            //ENDIF
                            }
                        //ENDIF
                        }
                    //ENDIF
                    }
                    u_xlat16_6.xyz = (bool(u_xlatb33)) ? u_xlat15.xyz : u_xlat16_5.xyz;
                    u_xlat16_6.w = 1.0;
                    if(!u_xlatb33){
                        u_xlatb15.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
                        u_xlatb15.x = u_xlatb15.y || u_xlatb15.x;
                        if(!u_xlatb15.x){
                            u_xlatb26.xy = equal(unity_DebugViewInfo.xxxx, vec4(101.0, 103.0, 101.0, 103.0)).xy;
                            u_xlati26 = int(uint(u_xlatb26.y) * 0xffffffffu | uint(u_xlatb26.x) * 0xffffffffu);
                            SV_Target0 = (int(u_xlati26) != 0) ? vec4(0.200000003, 0.200000003, 0.200000003, 0.0) : u_xlat16_6;
                        } else {
                            SV_Target0 = vec4(0.200000003, 0.200000003, 0.200000003, 0.0);
                            u_xlati26 = -1;
                        //ENDIF
                        }
                        u_xlati15 = int(uint(u_xlatb15.x) * 0xffffffffu | uint(u_xlati26));
                    } else {
                        SV_Target0 = u_xlat16_6;
                        u_xlati15 = -1;
                    //ENDIF
                    }
                    u_xlati33 = int(uint(u_xlatb33) * 0xffffffffu | uint(u_xlati15));
                } else {
                    SV_Target0 = u_xlat16_5;
                    u_xlati33 = -1;
                //ENDIF
                }
                u_xlati33 = int(uint(u_xlatb4) * 0xffffffffu | uint(u_xlati33));
            } else {
                SV_Target0 = u_xlat16_3;
                u_xlati33 = -1;
            //ENDIF
            }
            u_xlati22 = int(uint(u_xlatb22) * 0xffffffffu | uint(u_xlati33));
        } else {
            SV_Target0 = u_xlat16_2;
            u_xlati22 = -1;
        //ENDIF
        }
        u_xlati11 = int(uint(u_xlatb11.x) * 0xffffffffu | uint(u_xlati22));
    } else {
        SV_Target0 = u_xlat1;
        u_xlati11 = -1;
    //ENDIF
    }
    u_xlati0 = int(uint(u_xlatb0) * 0xffffffffu | uint(u_xlati11));
    if(u_xlati0 == 0) {
        u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
        u_xlat0.x = inversesqrt(u_xlat0.x);
        u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
        u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
        u_xlat33 = u_xlat10_1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
        u_xlatb33 = !!(u_xlat33<0.0);
#else
        u_xlatb33 = u_xlat33<0.0;
#endif
        if((int(u_xlatb33) * int(0xffffffffu))!=0){discard;}
        u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
        u_xlat16_2.xyw = u_xlat10_1.www * _SpecColor.xyz;
        SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
        u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn));
#else
        u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_ElementViewEleDrawOn);
#endif
        u_xlat16_2.z = (u_xlatb0) ? 0.0 : u_xlat16_2.w;
        SV_Target0.w = 0.0;
        u_xlat16_1.xyz = u_xlat1.xyz;
    } else {
        u_xlat16_1.x = float(0.0);
        u_xlat16_1.y = float(0.0);
        u_xlat16_1.z = float(0.0);
        u_xlat16_2.x = float(0.0);
        u_xlat16_2.y = float(0.0);
        u_xlat16_2.z = float(0.0);
    //ENDIF
    }
    SV_Target1.xyz = u_xlat16_1.xyz;
    SV_Target1.w = 0.0;
    SV_Target2.xyz = u_xlat16_2.xyz;
    SV_Target2.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD0.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat7;
float u_xlat9;
float u_xlat10;
void main()
{
    u_xlat0.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xy = u_xlat0.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xy = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.y / _GrassDisplacementArea.w);
    u_xlat1.xyz = textureLod(_GrassDisplacementTex, u_xlat1.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat9 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * in_COLOR0.y;
    u_xlat9 = u_xlat9 * _DisplacementParam.y;
    u_xlat7 = max(u_xlat1.z, _DisplacementParam.z);
    u_xlat1.xy = u_xlat1.xy * in_COLOR0.yy;
    u_xlat1.xy = u_xlat1.xy * _DisplacementParam.xx;
    u_xlat7 = min(u_xlat7, _DisplacementParam.w);
    u_xlat2.y = (-u_xlat9) * u_xlat7;
    u_xlat9 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat2.xz = u_xlat1.xy * vec2(0.75, 0.75);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD0.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat10;
float u_xlat14;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat4.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + u_xlat1.xyz;
    u_xlat2.xy = u_xlat4.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat14 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.w = sqrt(u_xlat14);
    u_xlat2.xyw = u_xlat2.xyw * in_COLOR0.yyy;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xyw = u_xlat2.xyw * _DisplacementParam.xxy;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = u_xlat10 * (-u_xlat2.w);
    u_xlat10 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + u_xlat1.xyz;
    u_xlat2 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat5;
float u_xlat13;
void main()
{
    u_xlat0.x = float(1.0) / _WindWaveLength;
    u_xlat4.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.x = dot(u_xlat4.xz, _MiHoYoWind.xz);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat1.x = _WindFrenquency * _WindStrength;
    u_xlat0.x = _Time.y * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat1.x * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat1.x = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = log2(in_COLOR0.y);
    u_xlat1.x = u_xlat1.x * 1.10000002;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * _MiHoYoWind.w;
    u_xlat1.x = u_xlat1.x * _WindBend + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x + (-u_xlat1.x);
    u_xlat5.xy = _MiHoYoWind.xz;
    u_xlat5.xy = u_xlat0.xx * u_xlat5.xy;
    u_xlat0.x = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = u_xlat0.xx * u_xlat5.xy;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat4.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat8;
float u_xlat10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = _WindFrenquency * _WindStrength;
    u_xlat4 = float(1.0) / _WindWaveLength;
    u_xlat1.xyz = in_TEXCOORD1.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TEXCOORD1.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TEXCOORD2.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat8.x = dot(u_xlat1.xz, _MiHoYoWind.xz);
    u_xlat4 = u_xlat4 * (-u_xlat8.x);
    u_xlat0.x = _Time.y * u_xlat0.x + u_xlat4;
    u_xlat4 = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat0.x = u_xlat4 * 0.628300011 + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 0.5;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat4 = abs(u_xlat0.x) * abs(u_xlat0.x);
    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = log2(in_COLOR0.y);
    u_xlat4 = u_xlat4 * 1.10000002;
    u_xlat4 = exp2(u_xlat4);
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat4 = u_xlat4 * _MiHoYoWind.w;
    u_xlat4 = u_xlat4 * _WindBend + 1.0;
    u_xlat4 = u_xlat4 * u_xlat4 + (-u_xlat4);
    u_xlat8.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat8.xy * u_xlat0.xx;
    u_xlat12 = _MiHoYoWind.w * _WindStrength;
    u_xlat2.xz = vec2(u_xlat12) * u_xlat0.xz;
    u_xlat2.y = 0.0;
    u_xlat3.xz = _MiHoYoWind.xz;
    u_xlat3.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat2.xy = u_xlat1.xz + (-_GrassDisplacementArea.xy);
    u_xlat2.xy = vec2(u_xlat2.x / _GrassDisplacementArea.z, u_xlat2.y / _GrassDisplacementArea.w);
    u_xlat2.xyz = textureLod(_GrassDisplacementTex, u_xlat2.xy, 0.0).xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = u_xlat13 * in_COLOR0.y;
    u_xlat13 = u_xlat13 * _DisplacementParam.y;
    u_xlat10 = max(u_xlat2.z, _DisplacementParam.z);
    u_xlat2.xy = u_xlat2.xy * in_COLOR0.yy;
    u_xlat2.xy = u_xlat2.xy * _DisplacementParam.xx;
    u_xlat10 = min(u_xlat10, _DisplacementParam.w);
    u_xlat3.y = (-u_xlat13) * u_xlat10;
    u_xlat13 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat2.xy = vec2(u_xlat13) * u_xlat2.xy;
    u_xlat3.xz = u_xlat2.xy * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MiHoYoWind;
uniform 	vec4 _GrassDisplacementArea;
uniform 	vec4 _DisplacementParam;
uniform 	float _WindStrength;
uniform 	float _WindFrenquency;
uniform 	float _WindWaveLength;
uniform 	float _WindBend;
uniform 	float _WindPhaseDivergence;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _GrassDisplacementTex;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati6;
vec2 u_xlat10;
float u_xlat11;
float u_xlat15;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0.x = log2(in_COLOR0.y);
    u_xlat0.x = u_xlat0.x * 1.10000002;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat5 = u_xlat0.x * _MiHoYoWind.w;
    u_xlat5 = u_xlat5 * _WindBend + 1.0;
    u_xlat5 = u_xlat5 * u_xlat5 + (-u_xlat5);
    u_xlat10.x = in_COLOR0.x * _WindPhaseDivergence;
    u_xlat15 = _WindFrenquency * _WindStrength;
    u_xlat1.x = float(1.0) / _WindWaveLength;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat2.xyz = in_TEXCOORD1.yyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TEXCOORD1.xxx + u_xlat2.xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TEXCOORD2.xxx + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat11 = dot(u_xlat2.xz, _MiHoYoWind.xz);
    u_xlat1.x = u_xlat1.x * (-u_xlat11);
    u_xlat15 = _Time.y * u_xlat15 + u_xlat1.x;
    u_xlat10.x = u_xlat10.x * 0.628300011 + u_xlat15;
    u_xlat10.x = u_xlat10.x + 0.5;
    u_xlat10.x = fract(u_xlat10.x);
    u_xlat10.x = u_xlat10.x * 2.0 + -1.0;
    u_xlat15 = abs(u_xlat10.x) * abs(u_xlat10.x);
    u_xlat10.x = -abs(u_xlat10.x) * 2.0 + 3.0;
    u_xlat10.x = u_xlat10.x * u_xlat15;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat10.xy = _MiHoYoWind.xz;
    u_xlat0.xz = u_xlat10.xy * u_xlat0.xx;
    u_xlat15 = _MiHoYoWind.w * _WindStrength;
    u_xlat3.xz = vec2(u_xlat15) * u_xlat0.xz;
    u_xlat3.y = 0.0;
    u_xlat4.xz = _MiHoYoWind.xz;
    u_xlat4.y = 0.0;
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat3 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3] * in_POSITION0.wwww + u_xlat3;
    u_xlat1.xzw = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xzw;
    u_xlat15 = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat1.xz = u_xlat2.xz + (-_GrassDisplacementArea.xy);
    u_xlat1.xz = vec2(u_xlat1.x / _GrassDisplacementArea.z, u_xlat1.z / _GrassDisplacementArea.w);
    u_xlat1.xzw = textureLod(_GrassDisplacementTex, u_xlat1.xz, 0.0).xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat17 = dot(u_xlat1.xz, u_xlat1.xz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat17 = u_xlat17 * in_COLOR0.y;
    u_xlat17 = u_xlat17 * _DisplacementParam.y;
    u_xlat16 = max(u_xlat1.w, _DisplacementParam.z);
    u_xlat1.xz = u_xlat1.xz * in_COLOR0.yy;
    u_xlat1.xz = u_xlat1.xz * _DisplacementParam.xx;
    u_xlat16 = min(u_xlat16, _DisplacementParam.w);
    u_xlat3.y = u_xlat16 * (-u_xlat17);
    u_xlat16 = in_COLOR0.x * 0.649999976 + 1.13;
    u_xlat1.xz = vec2(u_xlat16) * u_xlat1.xz;
    u_xlat3.xz = u_xlat1.xz * vec2(0.75, 0.75);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat2.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD0.xyz = u_xlat1.xxx * u_xlat2.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
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
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2 = vec4(0.0, 0.0, 0.0, 0.0);
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
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" "MIHOYO_GRASS_DISPLACEMENT" "PLANTS_WIND" "PLANTS_INTERACTION" }
""
}
}
}
 UsePass "miHoYo/Shadow/ShadowMapPass Cutout/LSPSM"
}
}