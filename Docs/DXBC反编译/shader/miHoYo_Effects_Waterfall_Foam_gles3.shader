//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Waterfall_Foam" {
Properties {
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_FoamColor ("FoamColor", Color) = (1,1,1,0)
_Normal01 ("Normal01", 2D) = "white" { }
_Normal01_U_Speed ("Normal01_U_Speed", Float) = 0
_Normal01_VSpeed ("Normal01_V-Speed", Float) = 0
_Reflection ("Reflection", Cube) = "black" { }
_ReflectionBrightness ("ReflectionBrightness", Float) = 1
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 1
_FoamTex ("FoamTex", 2D) = "white" { }
_DayColor ("DayColor", Color) = (1,1,1,1)
_FoamSpeed ("FoamSpeed", Float) = 1
_MaskTex ("MaskTex", 2D) = "white" { }
_DetailBrightness ("DetailBrightness", Float) = 0.35
_texcoord ("", 2D) = "white" { }
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "SUBSHADER 0 PASS 0"
  Tags { "DebugView" = "On" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 51131
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat5;
lowp float u_xlat10_5;
float u_xlat9;
float u_xlat12;
mediump float u_xlat16_12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_12 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_12) * u_xlat0.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat5.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat5.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat5.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_5 = texture(_FoamTex, u_xlat5.xy).x;
    u_xlat16_1 = u_xlat10_5 + u_xlat10_1;
    u_xlat5.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat5.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat5.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_5 = texture(_MaskTex, u_xlat5.xy).x;
    u_xlat1.x = u_xlat10_5 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat9 = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9 * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat14;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.z = _MHYZBias * u_xlat0.w + u_xlat0.z;
    gl_Position = u_xlat0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    u_xlat16_3.x = u_xlat2.y * u_xlat2.y;
    u_xlat16_3.x = u_xlat2.x * u_xlat2.x + (-u_xlat16_3.x);
    u_xlat16_4 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_5.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_3.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat0.xyz = u_xlat0.xyw * u_xlat6.xyz;
    u_xlat0.w = u_xlat0.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.xyz = vec3(u_xlat6.z * u_xlat0.x, u_xlat6.y * u_xlat0.y, u_xlat6.z * u_xlat0.w);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec2 u_xlat15;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat24;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    vs_TEXCOORD5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_6.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_5.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_5.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_5.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_5.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat7.x = float(0.5);
    u_xlat7.z = float(0.5);
    u_xlat7.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat7.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat7.z * u_xlat1.x, u_xlat7.y * u_xlat1.y, u_xlat7.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
mediump float u_xlat16_22;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTexture, u_xlat6.xy).x;
    u_xlat6.x = _ZBufferParams.z * u_xlat6.x + _ZBufferParams.w;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp float u_xlat10_1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec2 u_xlat6;
lowp float u_xlat10_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
void main()
{
    u_xlat0.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat1.x = _Time.y * _Normal01_U_Speed + u_xlat0.x;
    u_xlat1.y = _Time.y * _Normal01_VSpeed + u_xlat0.y;
    u_xlat10_0.xyz = texture(_Normal01, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = u_xlat16_2.xyz * _DistortionIntensity.xyz;
    u_xlat1.x = vs_TEXCOORD6.x;
    u_xlat1.y = vs_TEXCOORD8.x;
    u_xlat1.z = vs_TEXCOORD7.x;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.y;
    u_xlat3.y = vs_TEXCOORD8.y;
    u_xlat3.z = vs_TEXCOORD7.y;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = vs_TEXCOORD6.z;
    u_xlat3.y = vs_TEXCOORD8.z;
    u_xlat3.z = vs_TEXCOORD7.z;
    u_xlat1.z = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat15)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_Reflection, u_xlat0.xyz).xyz;
    u_xlat0.xyz = vec3(_ReflectionBrightness) * u_xlat10_0.xyz + (-_FoamColor.xyz);
    u_xlat0.xyz = vec3(_ReflectionIntensity) * u_xlat0.xyz + _FoamColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = vec3(u_xlat0.x * _ES_MainLightColor.xxyz.y, u_xlat0.y * _ES_MainLightColor.xxyz.z, u_xlat0.z * float(_ES_MainLightColor.z));
    u_xlat16_15 = max(_LightColor0.w, 1.0);
    u_xlat0.xyz = vec3(u_xlat16_15) * u_xlat0.xyz;
    u_xlat1.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = u_xlat1.y * _HeigtFogParams.x;
    u_xlat16 = u_xlat15 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.00999999978<abs(u_xlat15));
#else
    u_xlatb15 = 0.00999999978<abs(u_xlat15);
#endif
    u_xlat16_2.x = (u_xlatb15) ? u_xlat16 : 1.0;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat16 = u_xlat15 * _HeigtFogParams.y;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16_2.x = exp2((-u_xlat16_2.x));
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16 = u_xlat1.y * _HeigtFogParams2.x;
    u_xlat3.x = u_xlat16 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_7 = (u_xlatb16) ? u_xlat3.x : 1.0;
    u_xlat16 = u_xlat15 * _HeigtFogParams2.y;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16_7 = exp2((-u_xlat16_7));
    u_xlat16_2.y = (-u_xlat16_7) + 1.0;
    u_xlat16_2.xy = max(u_xlat16_2.xy, vec2(0.0, 0.0));
    u_xlat16_2.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16 = u_xlat15 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_7 = (-u_xlat16) + 2.0;
    u_xlat16_7 = u_xlat16 * u_xlat16_7;
    u_xlat16 = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_2.x = u_xlat16 * u_xlat16_2.x;
    u_xlat16 = min(u_xlat16_2.x, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat16) + 1.0;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat6.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat1.x)>=u_xlat6.x);
#else
    u_xlatb1 = (-u_xlat1.x)>=u_xlat6.x;
#endif
    u_xlat6.x = u_xlat15 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat15 + (-_HeigtFogRamp.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat11 * u_xlat6.x;
    u_xlat11 = u_xlat6.x * _HeigtFogColDelta.w;
    u_xlat1.x = (u_xlatb1) ? u_xlat11 : u_xlat6.x;
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * unity_FogColor.w;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = min(u_xlat1.x, _HeigtFogColBase.w);
    u_xlat6.x = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat6.x) + 2.0;
    u_xlat16_2.x = u_xlat6.x * u_xlat16_2.x;
    u_xlat8.xyz = u_xlat16_2.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat8.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat8.xyz = vec3(u_xlat15) * u_xlat4.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat1.xxx * u_xlat8.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat15 = u_xlat3.x * u_xlat15;
    u_xlat1.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat3.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.x = _Time.y * _FoamSpeed;
    u_xlat6.xy = u_xlat1.xx * vec2(0.0500000007, 0.600000024);
    u_xlat3.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat6.xy = u_xlat3.xy * vec2(1.35000002, 0.800000012) + u_xlat6.xy;
    u_xlat1.xw = u_xlat1.xx * vec2(-0.0500000007, 0.5) + u_xlat3.xy;
    u_xlat10_1 = texture(_FoamTex, u_xlat1.xw).x;
    u_xlat10_6 = texture(_FoamTex, u_xlat6.xy).x;
    u_xlat16_1 = u_xlat10_6 + u_xlat10_1;
    u_xlat6.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat6.x + u_xlat16_1;
    u_xlat1.x = u_xlat1.x * _DetailBrightness;
    u_xlat6.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_6 = texture(_MaskTex, u_xlat6.xy).x;
    u_xlat1.x = u_xlat10_6 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.x = texture(_CameraDepthTextureScaled, u_xlat6.xy).x;
    u_xlat6.x = u_xlat6.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat11 = u_xlat6.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat6.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat11 * u_xlat16 + u_xlat6.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlat0.w = u_xlat1.x * _DayColor.w;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat11;
mediump float u_xlat16_12;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat24;
bool u_xlatb24;
float u_xlat27;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position = u_xlat2;
    vs_TEXCOORD2.zw = u_xlat2.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat24 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat18 = u_xlat24 * -1.44269502;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = u_xlat18 / u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat24));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat24);
#endif
    u_xlat16_4.x = (u_xlatb24) ? u_xlat18 : 1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = sqrt(u_xlat24);
    u_xlat18 = u_xlat24 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat18 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat27 = u_xlat18 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.00999999978<abs(u_xlat18));
#else
    u_xlatb18 = 0.00999999978<abs(u_xlat18);
#endif
    u_xlat16_12 = (u_xlatb18) ? u_xlat27 : 1.0;
    u_xlat18 = u_xlat24 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat18 = u_xlat24 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat18) + 2.0;
    u_xlat16_12 = u_xlat18 * u_xlat16_12;
    u_xlat18 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat18 = u_xlat18 + 1.0;
    u_xlat16_4.x = u_xlat18 * u_xlat16_4.x;
    u_xlat18 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat27 = (-u_xlat18) + 1.0;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat5.xyz);
    u_xlat11 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat11);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat11;
#endif
    u_xlat11 = u_xlat24 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat5.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = vec3(u_xlat24) * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
    u_xlat24 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat27 * u_xlat24;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat24 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat24) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_4.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_4.x);
    u_xlat16_3 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat5.x = float(0.5);
    u_xlat5.z = float(0.5);
    u_xlat5.y = _ProjectionParams.x;
    u_xlat2.xyz = u_xlat2.xyw * u_xlat5.xyz;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xyz = vec3(u_xlat5.z * u_xlat1.x, u_xlat5.y * u_xlat1.y, u_xlat5.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat1.xyz;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat0.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec2 u_xlat7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_11;
vec2 u_xlat15;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = _Time.y * _FoamSpeed;
    u_xlat7.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat0.xx * vec2(0.0500000007, 0.600000024);
    u_xlat0.xw = u_xlat0.xx * vec2(-0.0500000007, 0.5) + u_xlat7.xy;
    u_xlat7.xy = u_xlat7.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat2.xyz;
    u_xlat15.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat3.x = _Time.y * _Normal01_U_Speed + u_xlat15.x;
    u_xlat3.y = _Time.y * _Normal01_VSpeed + u_xlat15.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat3.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_4.xyz * _DistortionIntensity.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat15.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat15.x = inversesqrt(u_xlat15.x);
    u_xlat3.xyz = u_xlat15.xxx * u_xlat5.xyz;
    u_xlat15.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat15.x = u_xlat15.x + u_xlat15.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat15.xxx) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_0 = texture(_FoamTex, u_xlat0.xw).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_0 = u_xlat10_7 + u_xlat10_0;
    u_xlat7.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x + u_xlat16_0;
    u_xlat0.x = u_xlat0.x * _DetailBrightness;
    u_xlat10_7 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat0.x = u_xlat10_7 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat23) + 2.0;
    u_xlat16_4.x = u_xlat23 * u_xlat16_4.x;
    u_xlat3.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat5.x = u_xlat23 * -1.44269502;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat23 = u_xlat5.x / u_xlat23;
    u_xlat16_4.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_4.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_4.xy = u_xlat9.yx * u_xlat16_4.xy;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_11 = exp2((-u_xlat16_4.y));
    u_xlat16_4.y = (-u_xlat16_11) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat2.x) + 2.0;
    u_xlat16_11 = u_xlat2.x * u_xlat16_11;
    u_xlat2.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_4.x = u_xlat2.x * u_xlat16_4.x;
    u_xlat2.x = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
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
uniform 	vec4 hlslcc_mtx4x4_mhyJitteredVP[4];
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
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat11;
mediump float u_xlat16_12;
vec3 u_xlat13;
float u_xlat17;
bool u_xlatb17;
float u_xlat19;
float u_xlat24;
float u_xlat27;
bool u_xlatb27;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat1.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position = u_xlat1;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat3.xyz = u_xlat8.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat17 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat27 = u_xlat17 * -1.44269502;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat27 = u_xlat27 / u_xlat17;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.00999999978<abs(u_xlat17));
#else
    u_xlatb17 = 0.00999999978<abs(u_xlat17);
#endif
    u_xlat16_4.x = (u_xlatb17) ? u_xlat27 : 1.0;
    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat27 = u_xlat17 * _HeigtFogParams.y;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat27 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat5 = u_xlat27 * -1.44269502;
    u_xlat5 = exp2(u_xlat5);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 / u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(0.00999999978<abs(u_xlat27));
#else
    u_xlatb27 = 0.00999999978<abs(u_xlat27);
#endif
    u_xlat16_12 = (u_xlatb27) ? u_xlat5 : 1.0;
    u_xlat27 = u_xlat17 * _HeigtFogParams2.y;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat16_12 = exp2((-u_xlat16_12));
    u_xlat16_4.y = (-u_xlat16_12) + 1.0;
    u_xlat16_4.xy = max(u_xlat16_4.xy, vec2(0.0, 0.0));
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat27 = u_xlat17 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat27) + 2.0;
    u_xlat16_12 = u_xlat27 * u_xlat16_12;
    u_xlat27 = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat27 = u_xlat27 + 1.0;
    u_xlat16_4.x = u_xlat27 * u_xlat16_4.x;
    u_xlat27 = min(u_xlat16_4.x, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat27) + 1.0;
    u_xlat13.x = _ProjectionParams.z * 0.999899983;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!((-u_xlat3.x)>=u_xlat13.x);
#else
    u_xlatb3 = (-u_xlat3.x)>=u_xlat13.x;
#endif
    u_xlat11 = u_xlat17 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat17 = u_xlat17 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat11) + 2.0;
    u_xlat11 = u_xlat19 * u_xlat11;
    u_xlat19 = u_xlat11 * _HeigtFogColDelta.w;
    u_xlat3.x = (u_xlatb3) ? u_xlat19 : u_xlat11;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * unity_FogColor.w;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = min(u_xlat3.x, _HeigtFogColBase.w);
    u_xlat11 = u_xlat8.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat11) + 2.0;
    u_xlat16_4.x = u_xlat11 * u_xlat16_4.x;
    u_xlat13.xyz = u_xlat16_4.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat13.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat13.xyz = vec3(u_xlat17) * u_xlat6.xyz + u_xlat13.xyz;
    u_xlat13.xyz = u_xlat3.xxx * u_xlat13.xyz;
    u_xlat17 = (-u_xlat3.x) + 1.0;
    vs_TEXCOORD0.w = u_xlat5 * u_xlat17;
    u_xlat3.xyz = vec3(u_xlat5) * u_xlat13.xyz;
    u_xlat17 = u_xlat8.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat8.xyz = vec3(u_xlat17) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    vs_TEXCOORD0.xyz = u_xlat8.xyz * vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat3.xyz;
    u_xlat16_4.x = u_xlat3.y * u_xlat3.y;
    u_xlat16_4.x = u_xlat3.x * u_xlat3.x + (-u_xlat16_4.x);
    u_xlat16_5 = u_xlat3.yzzx * u_xlat3.xyzz;
    u_xlat16_7.x = dot(unity_SHBr, u_xlat16_5);
    u_xlat16_7.y = dot(unity_SHBg, u_xlat16_5);
    u_xlat16_7.z = dot(unity_SHBb, u_xlat16_5);
    u_xlat16_4.xyz = unity_SHC.xyz * u_xlat16_4.xxx + u_xlat16_7.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_7.xyz;
    vs_TEXCOORD1.xyz = u_xlat16_4.xyz;
    vs_TEXCOORD1.w = 1.0;
    u_xlat6.x = float(0.5);
    u_xlat6.z = float(0.5);
    u_xlat6.y = _ProjectionParams.x;
    u_xlat1.xyz = u_xlat1.xyw * u_xlat6.xyz;
    u_xlat1.w = u_xlat1.y * 0.5;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4_mhyJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_mhyJitteredVP[3] * u_xlat2.wwww + u_xlat1;
    u_xlat2.xyz = vec3(u_xlat6.z * u_xlat1.x, u_xlat6.y * u_xlat1.y, u_xlat6.z * u_xlat1.w);
    vs_TEXCOORD3.zw = u_xlat1.zw;
    u_xlat2.w = u_xlat2.y * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5.w = 0.0;
    u_xlat8.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat8.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat8.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    vs_TEXCOORD7.xyz = u_xlat3.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat1.xyz = u_xlat0.yzx * u_xlat3.zxy;
    u_xlat0.xyz = u_xlat3.yzx * u_xlat0.zxy + (-u_xlat1.xyz);
    u_xlat24 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _LightColor0;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _FoamSpeed;
uniform 	vec4 _FoamTex_ST;
uniform 	float _DetailBrightness;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	vec4 _FoamColor;
uniform 	float _ReflectionBrightness;
uniform 	float _Normal01_U_Speed;
uniform 	vec4 _Normal01_ST;
uniform 	float _Normal01_VSpeed;
uniform 	vec4 _DistortionIntensity;
uniform 	float _ReflectionIntensity;
uniform 	vec3 _ES_MainLightColor;
uniform highp sampler2D _CameraDepthTextureScaled;
uniform lowp sampler2D _Normal01;
uniform lowp samplerCube _Reflection;
uniform lowp sampler2D _FoamTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
mediump float u_xlat16_7;
lowp float u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_12;
vec2 u_xlat14;
lowp float u_xlat10_14;
vec2 u_xlat15;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_22;
bool u_xlatb22;
float u_xlat23;
bool u_xlatb23;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD3.w);
    u_xlat7.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat14.x = (-u_xlat7.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat14.x + u_xlat7.x;
    u_xlat7.x = _Time.y * _FoamSpeed;
    u_xlat14.xy = vs_TEXCOORD4.xy * _FoamTex_ST.xy + _FoamTex_ST.zw;
    u_xlat1.xy = u_xlat7.xx * vec2(0.0500000007, 0.600000024);
    u_xlat15.xy = u_xlat7.xx * vec2(-0.0500000007, 0.5) + u_xlat14.xy;
    u_xlat7.xy = u_xlat14.xy * vec2(1.35000002, 0.800000012) + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD4.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat3.xy = vs_TEXCOORD4.xy * _Normal01_ST.xy + _Normal01_ST.zw;
    u_xlat4.x = _Time.y * _Normal01_U_Speed + u_xlat3.x;
    u_xlat4.y = _Time.y * _Normal01_VSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_Normal01, u_xlat4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat16_5.xyz * _DistortionIntensity.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat4.xyz;
    u_xlat21 = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + (-u_xlat2.xyz);
    u_xlat10_2.xyz = texture(_Reflection, u_xlat2.xyz).xyz;
    u_xlat2.xyz = vec3(_ReflectionBrightness) * u_xlat10_2.xyz + (-_FoamColor.xyz);
    u_xlat2.xyz = vec3(_ReflectionIntensity) * u_xlat2.xyz + _FoamColor.xyz;
    u_xlat10_21 = texture(_FoamTex, u_xlat15.xy).x;
    u_xlat10_7 = texture(_FoamTex, u_xlat7.xy).x;
    u_xlat16_7 = u_xlat10_7 + u_xlat10_21;
    u_xlat14.x = vs_TEXCOORD4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat14.x + u_xlat16_7;
    u_xlat7.x = u_xlat7.x * _DetailBrightness;
    u_xlat10_14 = texture(_MaskTex, u_xlat1.xy).x;
    u_xlat7.x = u_xlat10_14 * u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat2.xyz * _DayColor.xyz;
    u_xlat1.xyz = vec3(u_xlat1.x * _ES_MainLightColor.xxyz.y, u_xlat1.y * _ES_MainLightColor.xxyz.z, u_xlat1.z * float(_ES_MainLightColor.z));
    u_xlat16_22 = max(_LightColor0.w, 1.0);
    u_xlat1.xyz = vec3(u_xlat16_22) * u_xlat1.xyz;
    u_xlat2.xyz = vs_TEXCOORD5.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9.y = u_xlat2.x * _HeigtFogParams.y;
    u_xlat23 = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!((-u_xlat22)>=u_xlat3.x);
#else
    u_xlatb22 = (-u_xlat22)>=u_xlat3.x;
#endif
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat22 = (u_xlatb22) ? u_xlat3.x : u_xlat23;
    u_xlat22 = log2(u_xlat22);
    u_xlat22 = u_xlat22 * unity_FogColor.w;
    u_xlat22 = exp2(u_xlat22);
    u_xlat22 = min(u_xlat22, _HeigtFogColBase.w);
    u_xlat23 = vs_TEXCOORD5.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat23) + 2.0;
    u_xlat16_5.x = u_xlat23 * u_xlat16_5.x;
    u_xlat3.xyz = u_xlat16_5.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat23 = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat23 = u_xlat2.y * _HeigtFogParams.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.00999999978<abs(u_xlat23));
#else
    u_xlatb24 = 0.00999999978<abs(u_xlat23);
#endif
    u_xlat4.x = u_xlat23 * -1.44269502;
    u_xlat4.x = exp2(u_xlat4.x);
    u_xlat4.x = (-u_xlat4.x) + 1.0;
    u_xlat23 = u_xlat4.x / u_xlat23;
    u_xlat16_5.x = (u_xlatb24) ? u_xlat23 : 1.0;
    u_xlat9.x = u_xlat2.y * _HeigtFogParams2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb23 = !!(0.00999999978<abs(u_xlat9.x));
#else
    u_xlatb23 = 0.00999999978<abs(u_xlat9.x);
#endif
    u_xlat24 = u_xlat9.x * -1.44269502;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat9.x = u_xlat24 / u_xlat9.x;
    u_xlat16_5.y = (u_xlatb23) ? u_xlat9.x : 1.0;
    u_xlat9.x = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_5.xy = u_xlat9.yx * u_xlat16_5.xy;
    u_xlat16_5.x = exp2((-u_xlat16_5.x));
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_12 = exp2((-u_xlat16_5.y));
    u_xlat16_5.y = (-u_xlat16_12) + 1.0;
    u_xlat16_5.xy = max(u_xlat16_5.xy, vec2(0.0, 0.0));
    u_xlat16_5.x = u_xlat16_5.y + u_xlat16_5.x;
    u_xlat2.x = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_12 = (-u_xlat2.x) + 2.0;
    u_xlat16_12 = u_xlat2.x * u_xlat16_12;
    u_xlat2.x = u_xlat16_12 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat2.x = u_xlat2.x + 1.0;
    u_xlat16_5.x = u_xlat2.x * u_xlat16_5.x;
    u_xlat2.x = min(u_xlat16_5.x, _HeigtFogColBase.w);
    u_xlat9.x = vs_TEXCOORD5.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat9.xyz = u_xlat9.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat3.xyz = vec3(u_xlat22) * u_xlat3.xyz;
    u_xlat24 = (-u_xlat2.x) + 1.0;
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat2.xyz = u_xlat9.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat22 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat24 * u_xlat22;
    u_xlat0.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "MSAA_INTERPOLATION" "_SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}