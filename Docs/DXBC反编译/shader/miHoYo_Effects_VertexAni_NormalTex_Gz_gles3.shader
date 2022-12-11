//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/VertexAni_NormalTex_Gz" {
Properties {
_LerpDebug ("LerpDebug", Range(0, 1)) = 0
_NormalTex ("NormalTex", 2D) = "white" { }
_NormalTexPannerXY ("NormalTexPanner(XY)", Vector) = (0,0,0,0)
_NormalInnerScale ("NormalInnerScale", Range(0, 20)) = 6
_VertexAniRangeXY ("VertexAniRange(XY)", Vector) = (0,0,0,0)
_VertexAniOffsetThreshold ("VertexAniOffsetThreshold", Float) = 0
_FresnelColor ("FresnelColor", Color) = (1,1,1,1)
_FresnelColorScale ("FresnelColorScale", Float) = 1
_FresnelColorHighLightScale ("FresnelColorHighLightScale", Range(0, 1)) = 0.5
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorScale ("MainColorScale", Float) = 1
_LinearRamp ("LinearRamp", Float) = 0
_DissolveTex ("DissolveTex", 2D) = "white" { }
_DissolveChannelNum ("DissolveChannelNum", Range(0, 4)) = 1
_DissolveScale ("DissolveScale", Float) = 1
_DissolveEndColor ("DissolveEndColor", Color) = (1,1,1,1)
_DissolveTexPannerXY ("DissolveTexPanner(XY)", Vector) = (0,0,0,0)
_DissolveOffset ("DissolveOffset", Float) = 0
_AlphaScale ("AlphaScale", Float) = 1
[Header(Motion Vectors)] _MotionVectorsAlphaCutoff ("Motion Vectors Alpha Cutoff", Range(0, 1)) = 0.1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
[Header(Fog Mode)] [Toggle(EFFECTED_BY_FOG)] _EffectedByFog ("Effected by fog", Float) = 0
}
SubShader {
 Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 17002
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_9) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16 + u_xlat16_9;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_9) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16 + u_xlat16_9;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_9) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16 + u_xlat16_9;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_9) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16 + u_xlat16_9;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.y = -1.0 / _DissolveScale;
    u_xlat16_21 = (-_MainColor.w) + 1.0;
    u_xlat16_3.xw = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_12.x = u_xlat16_21 * u_xlat16_3.w + u_xlat16_3.y;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_12.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.y = -1.0 / _DissolveScale;
    u_xlat16_21 = (-_MainColor.w) + 1.0;
    u_xlat16_3.xw = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_12.x = u_xlat16_21 * u_xlat16_3.w + u_xlat16_3.y;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_12.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.y = -1.0 / _DissolveScale;
    u_xlat16_21 = (-_MainColor.w) + 1.0;
    u_xlat16_3.xw = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_12.x = u_xlat16_21 * u_xlat16_3.w + u_xlat16_3.y;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_12.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.y = -1.0 / _DissolveScale;
    u_xlat16_21 = (-_MainColor.w) + 1.0;
    u_xlat16_3.xw = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_12.x = u_xlat16_21 * u_xlat16_3.w + u_xlat16_3.y;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_12.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_9) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16 + u_xlat16_9;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_3.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-_MainColor.w) + 1.0;
    u_xlat16_10 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_10) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_3.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat1.w = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_16;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_2.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_2.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_MainColor.w) + 1.0;
    u_xlat16_9 = -1.0 / _DissolveScale;
    u_xlat16_16 = (-u_xlat16_9) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_16 + u_xlat16_9;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_2.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
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
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat21;
int u_xlati21;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat14 = u_xlat0.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<abs(u_xlat0.x));
#else
    u_xlatb0 = 0.00999999978<abs(u_xlat0.x);
#endif
    u_xlat16_3.x = (u_xlatb0) ? u_xlat14 : 1.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat14 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat14 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_10 = (u_xlatb14) ? u_xlat23 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat14 = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat14) + 2.0;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat14 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat14 = u_xlat14 + 1.0;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat14) + 1.0;
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
    u_xlat9 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat0.x = u_xlat0.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat0.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat14) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
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
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
float u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat1.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xyz = texture(_NormalTex, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xy = u_xlat16_2.xy * vec2(_NormalInnerScale);
    u_xlat16_3.z = u_xlat16_2.z;
    u_xlat16_23 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_23 = inversesqrt(u_xlat16_23);
    u_xlat16_3.xyz = vec3(u_xlat16_23) * u_xlat16_3.xyz;
    u_xlat4.x = vs_TEXCOORD6.x;
    u_xlat4.y = vs_TEXCOORD8.x;
    u_xlat4.z = vs_TEXCOORD7.x;
    u_xlat5.x = dot(u_xlat4.xyz, u_xlat16_3.xyz);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.y;
    u_xlat6.y = vs_TEXCOORD8.y;
    u_xlat6.z = vs_TEXCOORD7.y;
    u_xlat5.y = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat6.x = vs_TEXCOORD6.z;
    u_xlat6.y = vs_TEXCOORD8.z;
    u_xlat6.z = vs_TEXCOORD7.z;
    u_xlat5.z = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(u_xlat6.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat21) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.0799999982;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_21 = (-u_xlat16_2.x) * 1.10000002 + 0.899999976;
    u_xlat16_2.x = (-u_xlat16_2.x) * 1.10000002 + 1.0;
    u_xlat16_21 = u_xlat16_21 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat16_21 = u_xlat16_21 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
#else
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_21 + u_xlat16_2.x;
    u_xlat0.x = min(u_xlat16_0.x, 1.0);
    u_xlat0.y = u_xlat0.x + -0.25;
    u_xlat0.xy = max(u_xlat0.xy, vec2(9.99999975e-05, 0.0));
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat8.xyz;
    u_xlat0.xzw = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat0.xzw;
    u_xlat8.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat8.x = u_xlat8.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + _MainColor.xyz;
    u_xlat8.xyz = u_xlat8.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xzw = (-u_xlat8.xyz) * vec3(_MainColorScale) + u_xlat0.xzw;
    u_xlat16_2.xyz = u_xlat8.xyz * vec3(_MainColorScale);
    u_xlat0.xyz = u_xlat0.yyy * u_xlat0.xzw + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat21 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_23 = u_xlat21 + -0.150000006;
    u_xlat16_23 = u_xlat16_23 * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD3.www * u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_2 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_3 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_3 = min(abs(u_xlat16_3), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_3 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_3.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_3.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_3.w + u_xlat16_0.x;
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_3.x;
    u_xlat0.x = (-u_xlat21) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-_MainColor.w) + 1.0;
    u_xlat16_10 = -1.0 / _DissolveScale;
    u_xlat16_17 = (-u_xlat16_10) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_17 + u_xlat16_10;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_3.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = vs_COLOR0.w * _AlphaScale;
    u_xlat1.w = u_xlat0.x * u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD5.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.y = -1.0 / _DissolveScale;
    u_xlat16_21 = (-_MainColor.w) + 1.0;
    u_xlat16_3.xw = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_12.x = u_xlat16_21 * u_xlat16_3.w + u_xlat16_3.y;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_12.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
mediump float u_xlat16_1;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    vs_TEXCOORD5.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_13;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_30 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = -1.0 / _DissolveScale;
    u_xlat16_13 = (-_MainColor.w) + 1.0;
    u_xlat16_22 = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.x = u_xlat16_13 * u_xlat16_22 + u_xlat16_4.x;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_30 + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_4.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat16_3.xyz + vs_TEXCOORD3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati12 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati12 = u_xlati12 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati12 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD8.xyz = vec3(u_xlat12) * u_xlat0.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_21;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_3.y = -1.0 / _DissolveScale;
    u_xlat16_21 = (-_MainColor.w) + 1.0;
    u_xlat16_3.xw = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_12.x = u_xlat16_21 * u_xlat16_3.w + u_xlat16_3.y;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_3.x + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_12.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
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

uniform 	vec4 _Time;
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
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
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
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
float u_xlat7;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat14;
bool u_xlatb14;
float u_xlat16;
float u_xlat21;
int u_xlati21;
float u_xlat23;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1 = (-_VertexAniRangeXY.x) + _VertexAniRangeXY.y;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _VertexAniRangeXY.x;
    u_xlat0.xyz = vec3(u_xlat16_1) * in_NORMAL0.xyz;
    u_xlat16_1 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_1) * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlati21 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati21 = u_xlati21 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
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
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.x = u_xlat2.y * _HeigtFogParams.x;
    u_xlat14 = u_xlat0.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.00999999978<abs(u_xlat0.x));
#else
    u_xlatb0 = 0.00999999978<abs(u_xlat0.x);
#endif
    u_xlat16_3.x = (u_xlatb0) ? u_xlat14 : 1.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat14 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat14 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat23 = u_xlat14 * -1.44269502;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat23 = u_xlat23 / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.00999999978<abs(u_xlat14));
#else
    u_xlatb14 = 0.00999999978<abs(u_xlat14);
#endif
    u_xlat16_10 = (u_xlatb14) ? u_xlat23 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat14 = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat14) + 2.0;
    u_xlat16_10 = u_xlat14 * u_xlat16_10;
    u_xlat14 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat14 = u_xlat14 + 1.0;
    u_xlat16_3.x = u_xlat14 * u_xlat16_3.x;
    u_xlat14 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat23 = (-u_xlat14) + 1.0;
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
    u_xlat9 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat0.x = u_xlat0.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat9) + 2.0;
    u_xlat9 = u_xlat16 * u_xlat9;
    u_xlat16 = u_xlat9 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat16 : u_xlat9;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * unity_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat9 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat7) * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat9) + 2.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat5.xyz = u_xlat0.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat2.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat23 * u_xlat0.x;
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat5.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat14) + u_xlat2.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    vs_TEXCOORD5.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati21 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    vs_TEXCOORD7.xyz = u_xlat2.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat4.xyz = u_xlat0.yzx * u_xlat2.zxy;
    u_xlat0.xyz = u_xlat2.yzx * u_xlat0.zxy + (-u_xlat4.xyz);
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _MainColor;
uniform 	float _LinearRamp;
uniform 	mediump float _MainColorScale;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelColorScale;
uniform 	float _FresnelColorHighLightScale;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform 	mediump float _NormalInnerScale;
uniform 	mediump vec4 _DissolveEndColor;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _LerpDebug;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveScale;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD8;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_13;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_30;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.x = vs_TEXCOORD0.y + _LinearRamp;
    u_xlat16_9.xyz = _MainColor.xyz + vec3(0.75, 1.0, 0.948275924);
    u_xlat0.x = u_xlat0.x * -2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz + u_xlat16_9.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat2.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xyz = texture(_NormalTex, u_xlat2.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xy = u_xlat16_3.xy * vec2(_NormalInnerScale);
    u_xlat16_4.z = u_xlat16_3.z;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat5.x = vs_TEXCOORD6.x;
    u_xlat5.y = vs_TEXCOORD8.x;
    u_xlat5.z = vs_TEXCOORD7.x;
    u_xlat6.x = dot(u_xlat5.xyz, u_xlat16_4.xyz);
    u_xlat7.x = vs_TEXCOORD6.y;
    u_xlat7.y = vs_TEXCOORD8.y;
    u_xlat7.z = vs_TEXCOORD7.y;
    u_xlat6.y = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat8.x = vs_TEXCOORD6.z;
    u_xlat8.y = vs_TEXCOORD8.z;
    u_xlat8.z = vs_TEXCOORD7.z;
    u_xlat6.z = dot(u_xlat8.xyz, u_xlat16_4.xyz);
    u_xlat27 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = vec3(u_xlat27) * u_xlat6.xyz;
    u_xlat27 = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_30 = (-u_xlat27) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 9.99999975e-05);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.0799999982;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_4.x = (-u_xlat16_30) * 1.10000002 + 1.0;
    u_xlat16_27 = (-u_xlat16_30) * 1.10000002 + 0.899999976;
    u_xlat16_27 = u_xlat16_27 * 4.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat16_3.xyz);
    u_xlat5.y = dot(u_xlat7.xyz, u_xlat16_3.xyz);
    u_xlat5.z = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat28 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat11.xyz = vec3(u_xlat28) * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat1.xyz);
    u_xlat16_3.x = (-u_xlat1.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x + -0.899999976;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_27 = u_xlat16_27 + u_xlat16_3.x;
    u_xlat16_27 = min(u_xlat16_27, 1.0);
    u_xlat16_1.x = u_xlat16_27 + -0.25;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(_MainColorScale);
    u_xlat10.xyz = _FresnelColor.xyz + vec3(_FresnelColorHighLightScale);
    u_xlat16_27 = max(u_xlat16_27, 9.99999975e-05);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat10.xyz = vec3(u_xlat16_27) * u_xlat10.xyz;
    u_xlat10.xyz = _FresnelColor.xyz * vec3(_FresnelColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_MainColorScale) + u_xlat10.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat27 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat16_3.x = u_xlat27 + -0.150000006;
    u_xlat16_3.x = u_xlat16_3.x * 6.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = (-u_xlat0.xyz) + _DissolveEndColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_12.xyz + u_xlat0.xyz;
    u_xlat16_4.xyz = u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = vec3(vec3(_LerpDebug, _LerpDebug, _LerpDebug)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DissolveTexPannerXY.xy + u_xlat0.xy;
    u_xlat10_1 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_2 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_30 = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = -1.0 / _DissolveScale;
    u_xlat16_13 = (-_MainColor.w) + 1.0;
    u_xlat16_22 = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.x = u_xlat16_13 * u_xlat16_22 + u_xlat16_4.x;
    u_xlat0.x = vs_COLOR0.w * _AlphaScale;
    u_xlat16_9.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_9.x = u_xlat16_9.y + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_30 + u_xlat16_9.x;
    u_xlat9 = (-u_xlat27) + u_xlat16_9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat16_4.x) + u_xlat9;
    u_xlat9 = u_xlat9 * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat9 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = vs_TEXCOORD3.www * u_xlat16_3.xyz + vs_TEXCOORD3.xyz;
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
Keywords { "EFFECTED_BY_FOG" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
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
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" }
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
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 91787
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1.x = (-_VertexAniRangeXY.xxxy.z) + _VertexAniRangeXY.xxxy.w;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.xxxy.z;
    u_xlat16_1.xyz = u_xlat16_1.xxx * in_NORMAL0.xyz;
    u_xlat16_7 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
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
    SV_Target0 = vec4(0.497999996, 0.497999996, 0.0, 1.0);
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
int u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat0.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat0.xy;
    u_xlat0.x = textureLod(_NormalTex, u_xlat0.xy, 0.0).x;
    u_xlat16_1.x = (-_VertexAniRangeXY.xxxy.z) + _VertexAniRangeXY.xxxy.w;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _VertexAniRangeXY.xxxy.z;
    u_xlat16_1.xyz = u_xlat16_1.xxx * in_NORMAL0.xyz;
    u_xlat16_7 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati6 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati6 = u_xlati6 << 3;
    u_xlat1 = u_xlat0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
void main()
{
    SV_Target0 = vec4(0.497999996, 0.497999996, 0.0, 1.0);
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
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 154535
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat3.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat3.xy;
    u_xlat3.x = textureLod(_NormalTex, u_xlat3.xy, 0.0).x;
    u_xlat16_1.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat16_1.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlat1 = u_xlat3.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
uniform 	mediump float _VertexAniOffsetThreshold;
uniform 	mediump vec2 _VertexAniRangeXY;
uniform 	mediump vec2 _NormalTexPannerXY;
uniform 	vec4 _NormalTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NormalTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat3.xy = in_TEXCOORD0.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
    u_xlat3.xy = _Time.yy * _NormalTexPannerXY.xy + u_xlat3.xy;
    u_xlat3.x = textureLod(_NormalTex, u_xlat3.xy, 0.0).x;
    u_xlat16_1.x = (-_VertexAniRangeXY.xxyx.y) + _VertexAniRangeXY.xxyx.z;
    u_xlat16_1.x = u_xlat3.x * u_xlat16_1.x + _VertexAniRangeXY.xxyx.y;
    u_xlat16_1.xyz = u_xlat16_1.xxx * in_NORMAL0.xyz;
    u_xlat16_10 = in_TEXCOORD0.y + (-_VertexAniOffsetThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + in_POSITION0.xyz;
    u_xlati2 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati2 = u_xlati2 << 3;
    u_xlat1 = u_xlat3.yyyy * unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati2 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = u_xlat0.x * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _DissolveTexPannerXY;
uniform 	vec4 _DissolveTex_ST;
uniform 	mediump float _DissolveChannelNum;
uniform 	mediump float _DissolveOffset;
uniform 	mediump float _DissolveScale;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _DissolveTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_DissolveTexPannerXY.x, _DissolveTexPannerXY.y) + u_xlat0.xy;
    u_xlat10_0 = texture(_DissolveTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DissolveChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.x = min(abs(_DissolveChannelNum), 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3 = vs_TEXCOORD0.y + _DissolveOffset;
    u_xlat0.x = (-u_xlat3) + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-_MainColor.w) + 1.0;
    u_xlat16_4 = -1.0 / _DissolveScale;
    u_xlat16_7 = (-u_xlat16_4) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat0.x + (-u_xlat16_1.x);
    u_xlat0.x = u_xlat0.x * _DissolveScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = vs_COLOR0.w * _AlphaScale;
    u_xlat0.x = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat6.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat6.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati2.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat0.xy;
    SV_Target0.zw = vec2(0.0, 1.0);
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}