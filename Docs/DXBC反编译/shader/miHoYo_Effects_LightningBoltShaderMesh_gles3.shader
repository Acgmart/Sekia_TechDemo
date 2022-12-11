//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/LightningBoltShaderMesh" {
Properties {
_MainTex ("Main Texture (RGBA)", 2D) = "white" { }
_GlowTex ("Glow Texture (RGBA)", 2D) = "blue" { }
_TintColor ("Tint Color (RGB)", Color) = (1,1,1,1)
_GlowTintColor ("Glow Tint Color (RGB)", Color) = (1,1,1,1)
_InvFade ("Soft Particles Factor", Range(0.01, 100)) = 1
_JitterMultiplier ("Jitter Multiplier (Float)", Float) = 0
_Turbulence ("Turbulence (Float)", Float) = 0
_TurbulenceVelocity ("Turbulence Velocity (Vector)", Vector) = (0,0,0,0)
_SrcBlendMode ("SrcBlendMode (Source Blend Mode)", Float) = 5
_DstBlendMode ("DstBlendMode (Destination Blend Mode)", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 Pass {
  Name "GLOWPASS"
  LOD 400
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 63959
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
}
}
 Pass {
  Name "LINEPASS"
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 75453
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-06, 9.99999975e-06));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_OES_sample_variables
#extension GL_OES_sample_variables : enable
#endif

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
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
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
}
}
}
}