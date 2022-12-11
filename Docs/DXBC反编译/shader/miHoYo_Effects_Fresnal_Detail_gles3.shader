//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Fresnal_Detail" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_NormalTex ("NormalTex", 2D) = "bump" { }
_NormalIntensity ("NormalIntensity", Range(0, 20)) = 1
_NormalMapBlend ("NormalMapBlend", Range(0, 1)) = 0
_Fresnal_Scale ("Fresnal_Scale", Float) = 0.5
_Fresnal_Power ("Fresnal_Power", Float) = 1
_MaskTex ("MaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskChannel ("MaskChannel", Float) = 0
_MaskScale ("MaskScale", Float) = 1
_MaskTexPannerXY ("MaskTexPanner(XY)", Vector) = (0,0,0,0)
_MaskTexUVDistortScale ("MaskTexUVDistortScale", Float) = 0
_GlossThreshold ("GlossThreshold", Range(0, 1)) = 0
_GlossScale ("GlossScale", Float) = 1
_RampOffset ("RampOffset", Range(-1, 1)) = 0
_RampScale ("RampScale", Float) = 1
_DepthBrightnessThreshold ("DepthBrightnessThreshold", Float) = 0
_DepthBrightnessScale ("DepthBrightnessScale", Float) = 1
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
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
  GpuProgramID 51762
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-vs_TEXCOORD9.w);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-vs_TEXCOORD9.w);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = u_xlat4 * _ProjectionParams.z + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat8 = u_xlat4 * _ProjectionParams.z;
    u_xlat4 = u_xlat4 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat0.x = (-u_xlat0.x) * _ProjectionParams.z + u_xlat8;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = u_xlat4 * _ProjectionParams.z + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat8 = u_xlat4 * _ProjectionParams.z;
    u_xlat4 = u_xlat4 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat0.x = (-u_xlat0.x) * _ProjectionParams.z + u_xlat8;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = _ZBufferParams.z * u_xlat5 + _ZBufferParams.w;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat5 = (-u_xlat5) + u_xlat10;
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = (-u_xlat5.x) + u_xlat10;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = _ZBufferParams.z * u_xlat5 + _ZBufferParams.w;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat5 = (-u_xlat5) + u_xlat10;
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = (-u_xlat5.x) + u_xlat10;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat5 = u_xlat5 * _ProjectionParams.z;
    u_xlat5 = u_xlat10 * _ProjectionParams.z + (-u_xlat5);
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat3.x = u_xlat10 * _ProjectionParams.z;
    u_xlat5.x = (-u_xlat5.x) * _ProjectionParams.z + u_xlat3.x;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat5 = u_xlat5 * _ProjectionParams.z;
    u_xlat5 = u_xlat10 * _ProjectionParams.z + (-u_xlat5);
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat3.x = u_xlat10 * _ProjectionParams.z;
    u_xlat5.x = (-u_xlat5.x) * _ProjectionParams.z + u_xlat3.x;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-vs_TEXCOORD9.w);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTexture, u_xlat0.yz).x;
    u_xlat4 = _ZBufferParams.z * u_xlat4 + _ZBufferParams.w;
    u_xlat4 = float(1.0) / u_xlat4;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
    u_xlat4 = u_xlat4 + (-vs_TEXCOORD9.w);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = u_xlat4 * _ProjectionParams.z + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat8 = u_xlat4 * _ProjectionParams.z;
    u_xlat4 = u_xlat4 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat0.x = (-u_xlat0.x) * _ProjectionParams.z + u_xlat8;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
    u_xlat0.x = u_xlat4 * _ProjectionParams.z + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat12 = u_xlat0.w * _DayColor.w;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat12 * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
bvec4 u_xlatb3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat15;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_2.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat16_1.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_2.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * vs_TEXCOORD8.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Power;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat0.xy;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat0.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat0.xy;
    u_xlat2 = texture(_MaskTex, u_xlat0.xy);
    u_xlatb3 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat0.x * u_xlat12;
    u_xlat16_9 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_9 = u_xlat16_9 + (-_RampOffset);
    u_xlat16_9 = u_xlat16_9 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
    u_xlat16_9 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_9;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.x + u_xlat16_5;
    u_xlat0.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat4 = texture(_CameraDepthTextureScaled, u_xlat0.yz).x;
    u_xlat8 = u_xlat4 * _ProjectionParams.z;
    u_xlat4 = u_xlat4 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat0.x = (-u_xlat0.x) * _ProjectionParams.z + u_xlat8;
    u_xlat0.x = u_xlat0.x / _DepthBrightnessThreshold;
    u_xlat0.x = min(abs(u_xlat0.x), 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat0.x = u_xlat2.w * _DayColor.w;
    u_xlat3.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat8 = u_xlat4 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat4 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat8 * u_xlat12 + u_xlat4;
    u_xlat2.w = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = _ZBufferParams.z * u_xlat5 + _ZBufferParams.w;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat5 = (-u_xlat5) + u_xlat10;
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = (-u_xlat5.x) + u_xlat10;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = _ZBufferParams.z * u_xlat5 + _ZBufferParams.w;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat5 = (-u_xlat5) + u_xlat10;
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTexture, u_xlat3.yz).x;
    u_xlat10 = _ZBufferParams.z * u_xlat10 + _ZBufferParams.w;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = (-u_xlat5.x) + u_xlat10;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat5 = u_xlat5 * _ProjectionParams.z;
    u_xlat5 = u_xlat10 * _ProjectionParams.z + (-u_xlat5);
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
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
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD8.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat0.zw;
    vs_TEXCOORD9.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat3.x = u_xlat10 * _ProjectionParams.z;
    u_xlat5.x = (-u_xlat5.x) * _ProjectionParams.z + u_xlat3.x;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
float u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5 = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat5 = u_xlat5 * _ProjectionParams.z;
    u_xlat5 = u_xlat10 * _ProjectionParams.z + (-u_xlat5);
    u_xlat5 = u_xlat5 / _DepthBrightnessThreshold;
    u_xlat5 = min(abs(u_xlat5), 1.0);
    u_xlat5 = (-u_xlat5) + 1.0;
    u_xlat5 = u_xlat5 * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5 + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = vs_COLOR0 * _MainColor;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.x = u_xlat0.w * _DayColor.w;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat16_1.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat2;
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
out highp vec4 vs_TEXCOORD9;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat12;
float u_xlat14;
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
    vs_TEXCOORD5.w = 0.0;
    u_xlat4.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat14 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.xyz;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat3.xyz = u_xlat4.yzx * u_xlat2.zxy;
    u_xlat4.xyz = u_xlat2.yzx * u_xlat4.zxy + (-u_xlat3.xyz);
    u_xlat2.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD7.xyz = u_xlat4.xyz * u_xlat2.xxx;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD8.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD9.zw = u_xlat1.zw;
    vs_TEXCOORD9.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _GlossScale;
uniform 	float _NormalIntensity;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalMapBlend;
uniform 	mediump float _GlossThreshold;
uniform 	mediump float _MaskChannel;
uniform 	mediump vec2 _MaskTexPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexUVDistortScale;
uniform 	mediump float _MaskScale;
uniform 	float _Fresnal_Scale;
uniform 	float _Fresnal_Power;
uniform 	mediump float _RampOffset;
uniform 	mediump float _RampScale;
uniform 	mediump float _DepthBrightnessThreshold;
uniform 	mediump float _DepthBrightnessScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
in highp vec4 vs_TEXCOORD9;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec2 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
bvec4 u_xlatb4;
vec3 u_xlat5;
mediump float u_xlat16_6;
float u_xlat10;
mediump float u_xlat16_11;
float u_xlat15;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat10_0.xyz = texture(_NormalTex, u_xlat0.xy).xyz;
    u_xlat16_1.z = u_xlat10_0.z + u_xlat10_0.z;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = u_xlat16_2.xy * vec2(_NormalIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-0.0, -0.0, -2.0);
    u_xlat16_1.xyz = vec3(_NormalMapBlend) * u_xlat16_1.xyz + vec3(0.0, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD5.x;
    u_xlat0.y = vs_TEXCOORD7.x;
    u_xlat0.z = vs_TEXCOORD6.x;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.y;
    u_xlat3.y = vs_TEXCOORD7.y;
    u_xlat3.z = vs_TEXCOORD6.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat3.x = vs_TEXCOORD5.z;
    u_xlat3.y = vs_TEXCOORD7.z;
    u_xlat3.z = vs_TEXCOORD6.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.x = dot(vs_TEXCOORD8.xyz, vs_TEXCOORD8.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD8.xyz;
    u_xlat4.xyz = vs_TEXCOORD6.xyz * vec3(u_xlat15) + u_xlat3.xyz;
    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat16_6 = _GlossThreshold * -71.0 + 80.0;
    u_xlat16_11 = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_11 = log2(u_xlat16_11);
    u_xlat16_6 = u_xlat16_11 * u_xlat16_6;
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _GlossScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = u_xlat16_1.xx * vec2(_MaskTexUVDistortScale) + u_xlat4.xy;
    u_xlat4.xy = _Time.yy * _MaskTexPannerXY.xy + u_xlat4.xy;
    u_xlat2 = texture(_MaskTex, u_xlat4.xy);
    u_xlatb4 = equal(vec4(vec4(_MaskChannel, _MaskChannel, _MaskChannel, _MaskChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat15 = u_xlatb4.w ? u_xlat2.w : float(0.0);
    u_xlat15 = (u_xlatb4.z) ? u_xlat2.z : u_xlat15;
    u_xlat15 = (u_xlatb4.y) ? u_xlat2.y : u_xlat15;
    u_xlat15 = (u_xlatb4.x) ? u_xlat2.x : u_xlat15;
    u_xlat15 = u_xlat15 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 9.99999975e-05);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Fresnal_Scale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = vs_TEXCOORD9.zxy / vs_TEXCOORD9.www;
    u_xlat5.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat10 = texture(_CameraDepthTextureScaled, u_xlat3.yz).x;
    u_xlat3.x = u_xlat10 * _ProjectionParams.z;
    u_xlat5.x = (-u_xlat5.x) * _ProjectionParams.z + u_xlat3.x;
    u_xlat5.x = u_xlat5.x / _DepthBrightnessThreshold;
    u_xlat5.x = min(abs(u_xlat5.x), 1.0);
    u_xlat5.x = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat5.x * _DepthBrightnessScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat15 * u_xlat0.x;
    u_xlat16_11 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_11 = u_xlat16_11 + (-_RampOffset);
    u_xlat16_11 = u_xlat16_11 * _RampScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_11 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_6 * u_xlat15 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat5.x + u_xlat16_1.x;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = u_xlat10 * _ProjectionParams.z + (-vs_TEXCOORD9.w);
    u_xlat5.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat5.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5.x;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat5.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat5.xyz * _DayColor.xyz;
    u_xlat5.x = u_xlat2.w * _DayColor.w;
    u_xlat5.x = u_xlat5.x * _AlphaBrightness;
    u_xlat5.x = u_xlat16_1.x * u_xlat5.x;
    u_xlat3.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.w = min(max(u_xlat3.w, 0.0), 1.0);
#else
    u_xlat3.w = clamp(u_xlat3.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat3;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}