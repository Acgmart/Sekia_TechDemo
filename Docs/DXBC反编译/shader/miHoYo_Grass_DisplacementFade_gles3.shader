//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Grass/DisplacementFade" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 724
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 hlslcc_mtx4x4_GrassDisplacementFadeReprojection[4];
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yy * hlslcc_mtx4x4_GrassDisplacementFadeReprojection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_GrassDisplacementFadeReprojection[0].xy * vs_TEXCOORD0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_GrassDisplacementFadeReprojection[2].xy * vs_TEXCOORD0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4_GrassDisplacementFadeReprojection[3].xy * vs_TEXCOORD0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    SV_Target0 = u_xlat10_0;
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
}
}
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 73604
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	float _oneMinusFadeSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GrassDisplacementLastTex;
uniform lowp sampler2D _GrassDisplacementNoiseTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec2 u_xlat16_8;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xy = u_xlat0.xy * vec2(100.0, 100.0);
    u_xlat10 = texture(_GrassDisplacementNoiseTex, u_xlat16_1.xy).z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.5<u_xlat10);
#else
    u_xlatb15 = 0.5<u_xlat10;
#endif
    u_xlat2.xy = vec2(u_xlat10) * vec2(4.5, 0.5);
    u_xlat10 = (u_xlatb15) ? u_xlat2.x : u_xlat2.y;
    u_xlat15 = (-_oneMinusFadeSpeed) + 1.0;
    u_xlat10 = (-u_xlat15) * u_xlat10 + 1.0;
    u_xlat10 = max(u_xlat10, 0.0);
    u_xlat10 = min(u_xlat10, 0.995978415);
    u_xlat10_1 = texture(_GrassDisplacementLastTex, u_xlat0.xy);
    u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_3.x = u_xlat10_1.w + -1.0;
    u_xlat0.x = u_xlat10 + u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_4.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xy = u_xlat0.xx * u_xlat16_3.xy;
    SV_Target0.w = max(u_xlat0.x, u_xlat10_2.w);
    u_xlat16_3.x = dot(u_xlat16_3.xy, u_xlat16_3.xy);
    u_xlat16_0.x = u_xlat16_3.x + 0.00100000005;
    u_xlat16_8.xy = u_xlat10_2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_8.xy = u_xlat10_2.ww * u_xlat16_8.xy;
    u_xlat16_8.x = dot(u_xlat16_8.xy, u_xlat16_8.xy);
    u_xlat16_3.x = (-u_xlat16_3.x) + u_xlat16_8.x;
    u_xlat16_0.x = u_xlat16_3.x / u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat10_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
}
}
}
}