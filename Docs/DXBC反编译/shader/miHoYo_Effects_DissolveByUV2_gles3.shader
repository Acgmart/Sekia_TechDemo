//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/DissolveByUV2" {
Properties {
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_PatternTex ("PatternTex", 2D) = "black" { }
_RColor ("RColor", Color) = (1,1,1,1)
_GGlowColor ("GGlowColor", Color) = (1,1,1,1)
_GGlowColorScale ("GGlowColorScale", Float) = 1
_MultiTex ("MultiTex", 2D) = "white" { }
_MultiTexBPannerXY ("MultiTexBPanner(XY)", Vector) = (0,0,0,0)
_DissolveAni ("DissolveAni", Range(-1, 1)) = 0
_DissolveOutlineColor ("DissolveOutlineColor", Color) = (1,1,1,1)
_DissolveOutlineColorScale ("DissolveOutlineColorScale", Float) = 1
_FresnelPower ("FresnelPower", Range(0, 5)) = 4
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 20601
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_6.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * 1.04999995 + -0.0500000007;
    u_xlat16_6.x = (-u_xlat16_6.x) + vs_TEXCOORD1.y;
    u_xlat16_6.x = u_xlat16_6.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.y = min(max(u_xlat16_6.y, 0.0), 1.0);
#else
    u_xlat16_6.y = clamp(u_xlat16_6.y, 0.0, 1.0);
#endif
    u_xlat16_6.xz = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_10 = floor(u_xlat16_6.y);
    u_xlat16_14 = u_xlat16_6.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_14 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=0.00999999978);
#else
    u_xlatb0 = u_xlat16_3>=0.00999999978;
#endif
    u_xlat16_3 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_6.x = (-u_xlat16_6.x) + u_xlat16_3;
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * _DayColor.w;
    u_xlat0.w = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_14) + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_10 * u_xlat16_6.x + u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat9.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat1.xy).xy;
    u_xlat10_9 = texture(_MultiTex, u_xlat9.xy).z;
    u_xlat16_5 = (-u_xlat10_1.y) * u_xlat10_9 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_1.xzw = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_6.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat16_1.xzw + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_1.xyz = texture(_PatternTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_6.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * 1.04999995 + -0.0500000007;
    u_xlat16_6.x = (-u_xlat16_6.x) + vs_TEXCOORD1.y;
    u_xlat16_6.x = u_xlat16_6.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.y = min(max(u_xlat16_6.y, 0.0), 1.0);
#else
    u_xlat16_6.y = clamp(u_xlat16_6.y, 0.0, 1.0);
#endif
    u_xlat16_6.xz = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_10 = floor(u_xlat16_6.y);
    u_xlat16_14 = u_xlat16_6.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_14 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=0.00999999978);
#else
    u_xlatb0 = u_xlat16_3>=0.00999999978;
#endif
    u_xlat16_3 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_6.x = (-u_xlat16_6.x) + u_xlat16_3;
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * _DayColor.w;
    u_xlat0.w = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_14) + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_10 * u_xlat16_6.x + u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat9.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat1.xy).xy;
    u_xlat10_9 = texture(_MultiTex, u_xlat9.xy).z;
    u_xlat16_5 = (-u_xlat10_1.y) * u_xlat10_9 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_1.xzw = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_6.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat16_1.xzw + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_1.xyz = texture(_PatternTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat12.xy).xy;
    u_xlat12.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat12.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_12 = texture(_MultiTex, u_xlat12.xy).z;
    u_xlat16_12 = (-u_xlat10_1.y) * u_xlat10_12 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * 1.04999995 + -0.0500000007;
    u_xlat16_2.x = (-u_xlat16_2.x) + vs_TEXCOORD1.y;
    u_xlat16_2.x = u_xlat16_2.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.y = min(max(u_xlat16_2.y, 0.0), 1.0);
#else
    u_xlat16_2.y = clamp(u_xlat16_2.y, 0.0, 1.0);
#endif
    u_xlat16_2.xz = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlat16_14 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_14 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_20>=0.00999999978);
#else
    u_xlatb12 = u_xlat16_20>=0.00999999978;
#endif
    u_xlat16_20 = (u_xlatb12) ? 1.0 : 0.0;
    u_xlat16_8 = floor(u_xlat16_2.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_14) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8 * u_xlat16_2.x + u_xlat16_14;
    u_xlat12.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat3.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * vs_TEXCOORD6.xyz;
    u_xlat12.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_8 = (-u_xlat12.x) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 9.99999975e-05);
    u_xlat16_8 = log2(u_xlat16_8);
    u_xlat16_8 = u_xlat16_8 * _FresnelPower;
    u_xlat16_8 = exp2(u_xlat16_8);
    u_xlat16_2.x = u_xlat16_8 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_20 * _DayColor.w;
    u_xlat0.w = u_xlat16_2.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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

uniform 	vec3 _WorldSpaceCameraPos;
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat12.xy).xy;
    u_xlat12.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat12.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_12 = texture(_MultiTex, u_xlat12.xy).z;
    u_xlat16_12 = (-u_xlat10_1.y) * u_xlat10_12 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * 1.04999995 + -0.0500000007;
    u_xlat16_2.x = (-u_xlat16_2.x) + vs_TEXCOORD1.y;
    u_xlat16_2.x = u_xlat16_2.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.y = min(max(u_xlat16_2.y, 0.0), 1.0);
#else
    u_xlat16_2.y = clamp(u_xlat16_2.y, 0.0, 1.0);
#endif
    u_xlat16_2.xz = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlat16_14 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_14 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_20>=0.00999999978);
#else
    u_xlatb12 = u_xlat16_20>=0.00999999978;
#endif
    u_xlat16_20 = (u_xlatb12) ? 1.0 : 0.0;
    u_xlat16_8 = floor(u_xlat16_2.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_14) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8 * u_xlat16_2.x + u_xlat16_14;
    u_xlat12.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat3.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * vs_TEXCOORD6.xyz;
    u_xlat12.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_8 = (-u_xlat12.x) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 9.99999975e-05);
    u_xlat16_8 = log2(u_xlat16_8);
    u_xlat16_8 = u_xlat16_8 * _FresnelPower;
    u_xlat16_8 = exp2(u_xlat16_8);
    u_xlat16_2.x = u_xlat16_8 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_20 * _DayColor.w;
    u_xlat0.w = u_xlat16_2.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_6.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * 1.04999995 + -0.0500000007;
    u_xlat16_6.x = (-u_xlat16_6.x) + vs_TEXCOORD1.y;
    u_xlat16_6.x = u_xlat16_6.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.y = min(max(u_xlat16_6.y, 0.0), 1.0);
#else
    u_xlat16_6.y = clamp(u_xlat16_6.y, 0.0, 1.0);
#endif
    u_xlat16_6.xz = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_10 = floor(u_xlat16_6.y);
    u_xlat16_14 = u_xlat16_6.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_14 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=0.00999999978);
#else
    u_xlatb0 = u_xlat16_3>=0.00999999978;
#endif
    u_xlat16_3 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_6.x = (-u_xlat16_6.x) + u_xlat16_3;
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * _DayColor.w;
    u_xlat0.w = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_14) + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_10 * u_xlat16_6.x + u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat9.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat1.xy).xy;
    u_xlat10_9 = texture(_MultiTex, u_xlat9.xy).z;
    u_xlat16_5 = (-u_xlat10_1.y) * u_xlat10_9 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_1.xzw = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_6.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat16_1.xzw + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_1.xyz = texture(_PatternTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2.x = (-u_xlat0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_6.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * 1.04999995 + -0.0500000007;
    u_xlat16_6.x = (-u_xlat16_6.x) + vs_TEXCOORD1.y;
    u_xlat16_6.x = u_xlat16_6.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.y = min(max(u_xlat16_6.y, 0.0), 1.0);
#else
    u_xlat16_6.y = clamp(u_xlat16_6.y, 0.0, 1.0);
#endif
    u_xlat16_6.xz = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_10 = floor(u_xlat16_6.y);
    u_xlat16_14 = u_xlat16_6.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_14 * u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=0.00999999978);
#else
    u_xlatb0 = u_xlat16_3>=0.00999999978;
#endif
    u_xlat16_3 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_6.x = (-u_xlat16_6.x) + u_xlat16_3;
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * _DayColor.w;
    u_xlat0.w = u_xlat16_3 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat16_14) + u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_10 * u_xlat16_6.x + u_xlat16_14;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat9.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat1.xy;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat1.xy).xy;
    u_xlat10_9 = texture(_MultiTex, u_xlat9.xy).z;
    u_xlat16_5 = (-u_xlat10_1.y) * u_xlat10_9 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_1.xzw = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_6.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_5) * u_xlat16_1.xzw + u_xlat16_6.xyz;
    u_xlat16_6.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat1.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_1.xyz = texture(_PatternTex, u_xlat1.xy).xyz;
    u_xlat16_1.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
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
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD5.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat12.xy).xy;
    u_xlat12.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat12.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_12 = texture(_MultiTex, u_xlat12.xy).z;
    u_xlat16_12 = (-u_xlat10_1.y) * u_xlat10_12 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * 1.04999995 + -0.0500000007;
    u_xlat16_2.x = (-u_xlat16_2.x) + vs_TEXCOORD1.y;
    u_xlat16_2.x = u_xlat16_2.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.y = min(max(u_xlat16_2.y, 0.0), 1.0);
#else
    u_xlat16_2.y = clamp(u_xlat16_2.y, 0.0, 1.0);
#endif
    u_xlat16_2.xz = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlat16_14 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_14 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_20>=0.00999999978);
#else
    u_xlatb12 = u_xlat16_20>=0.00999999978;
#endif
    u_xlat16_20 = (u_xlatb12) ? 1.0 : 0.0;
    u_xlat16_8 = floor(u_xlat16_2.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_14) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8 * u_xlat16_2.x + u_xlat16_14;
    u_xlat12.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat3.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * vs_TEXCOORD6.xyz;
    u_xlat12.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_8 = (-u_xlat12.x) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 9.99999975e-05);
    u_xlat16_8 = log2(u_xlat16_8);
    u_xlat16_8 = u_xlat16_8 * _FresnelPower;
    u_xlat16_8 = exp2(u_xlat16_8);
    u_xlat16_2.x = u_xlat16_8 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_20 * _DayColor.w;
    u_xlat0.w = u_xlat16_2.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in mediump vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    vs_TEXCOORD5.xyz = u_xlat3.xyz * u_xlat1.xxx;
    vs_TEXCOORD5.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    vs_TEXCOORD6.xyz = vec3(u_xlat0) * u_xlat1.xyz;
    vs_TEXCOORD6.w = 0.0;
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
uniform 	mediump float _ColorBrightness;
uniform 	vec4 _PatternTex_ST;
uniform 	mediump vec4 _DayColor;
uniform 	mediump vec4 _GGlowColor;
uniform 	mediump float _GGlowColorScale;
uniform 	mediump vec4 _RColor;
uniform 	vec4 _MultiTex_ST;
uniform 	mediump vec2 _MultiTexBPannerXY;
uniform 	mediump vec4 _DissolveOutlineColor;
uniform 	mediump float _DissolveOutlineColorScale;
uniform 	mediump float _DissolveAni;
uniform 	mediump float _FresnelPower;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _MultiTex;
uniform lowp sampler2D _PatternTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
vec2 u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat12.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat12.xy).xy;
    u_xlat12.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat12.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_12 = texture(_MultiTex, u_xlat12.xy).z;
    u_xlat16_12 = (-u_xlat10_1.y) * u_xlat10_12 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_12) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_2.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * 1.04999995 + -0.0500000007;
    u_xlat16_2.x = (-u_xlat16_2.x) + vs_TEXCOORD1.y;
    u_xlat16_2.x = u_xlat16_2.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.y = min(max(u_xlat16_2.y, 0.0), 1.0);
#else
    u_xlat16_2.y = clamp(u_xlat16_2.y, 0.0, 1.0);
#endif
    u_xlat16_2.xz = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlat16_14 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_14 = (-u_xlat16_14) + vs_TEXCOORD1.y;
    u_xlat16_14 = u_xlat16_14 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_20 = u_xlat16_14 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_20>=0.00999999978);
#else
    u_xlatb12 = u_xlat16_20>=0.00999999978;
#endif
    u_xlat16_20 = (u_xlatb12) ? 1.0 : 0.0;
    u_xlat16_8 = floor(u_xlat16_2.y);
    u_xlat16_14 = (-u_xlat16_14) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_20;
    u_xlat16_2.x = (-u_xlat16_14) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_8 * u_xlat16_2.x + u_xlat16_14;
    u_xlat12.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat3.xyz = u_xlat12.xxx * vs_TEXCOORD5.xyz;
    u_xlat12.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat4.xyz = u_xlat12.xxx * vs_TEXCOORD6.xyz;
    u_xlat12.x = dot(u_xlat4.xyz, u_xlat3.xyz);
    u_xlat16_8 = (-u_xlat12.x) + 1.0;
    u_xlat16_8 = max(u_xlat16_8, 9.99999975e-05);
    u_xlat16_8 = log2(u_xlat16_8);
    u_xlat16_8 = u_xlat16_8 * _FresnelPower;
    u_xlat16_8 = exp2(u_xlat16_8);
    u_xlat16_2.x = u_xlat16_8 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_20 * _DayColor.w;
    u_xlat0.w = u_xlat16_2.x * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
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
Keywords { "INSTANCING_ON" }
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
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 116666
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
  GpuProgramID 132141
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
bool u_xlatb1;
ivec2 u_xlati2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * 1.04999995 + -0.0500000007;
    u_xlat16_0.x = (-u_xlat16_0.x) + vs_TEXCOORD1.y;
    u_xlat16_0.x = u_xlat16_0.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.y = min(max(u_xlat16_0.y, 0.0), 1.0);
#else
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
#endif
    u_xlat16_0.xy = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3 = u_xlat16_0.y * 1.04999995 + -0.0500000007;
    u_xlat16_3 = (-u_xlat16_3) + vs_TEXCOORD1.y;
    u_xlat16_3 = u_xlat16_3 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_3 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x>=0.00999999978);
#else
    u_xlatb1 = u_xlat16_0.x>=0.00999999978;
#endif
    u_xlat4 = _DayColor.w * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlatb1 ? u_xlat4 : float(0.0);
    u_xlat16_0.x = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    u_xlati7.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat1.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat1.xy = sqrt(abs(u_xlat1.xy));
    u_xlati7.xy = (-u_xlati7.xy) + u_xlati2.xy;
    u_xlat7.xy = vec2(u_xlati7.xy);
    u_xlat1.xy = u_xlat7.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat1.xy;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MHYZBias;
uniform 	float _MotionVectorDepthBias;
uniform 	vec4 hlslcc_mtx4x4_NonJitteredVP[4];
uniform 	vec4 hlslcc_mtx4x4_PreviousVP[4];
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
layout(std140) uniform UnityInstancing_PerDraw0 {
	unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati3;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati3 = u_xlati3 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati3 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _DissolveAni;
uniform 	float _AlphaBrightness;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
bool u_xlatb1;
ivec2 u_xlati2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0.x = _DissolveAni;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * 1.04999995 + -0.0500000007;
    u_xlat16_0.x = (-u_xlat16_0.x) + vs_TEXCOORD1.y;
    u_xlat16_0.x = u_xlat16_0.x * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.y = _DissolveAni + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.y = min(max(u_xlat16_0.y, 0.0), 1.0);
#else
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
#endif
    u_xlat16_0.xy = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3 = u_xlat16_0.y * 1.04999995 + -0.0500000007;
    u_xlat16_3 = (-u_xlat16_3) + vs_TEXCOORD1.y;
    u_xlat16_3 = u_xlat16_3 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_3 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x>=0.00999999978);
#else
    u_xlatb1 = u_xlat16_0.x>=0.00999999978;
#endif
    u_xlat4 = _DayColor.w * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlatb1 ? u_xlat4 : float(0.0);
    u_xlat16_0.x = u_xlat1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb1 = u_xlat16_0.x<0.0;
#endif
    if((int(u_xlatb1) * int(0xffffffffu))!=0){discard;}
    u_xlat1.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5);
    u_xlat7.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat7.xy = u_xlat7.xy + vec2(1.0, 1.0);
    u_xlat1.xy = u_xlat7.xy * vec2(0.5, 0.5) + (-u_xlat1.xy);
    u_xlati7.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati2.xy = ivec2(uvec2(lessThan(u_xlat1.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat1.xy = sqrt(abs(u_xlat1.xy));
    u_xlati7.xy = (-u_xlati7.xy) + u_xlati2.xy;
    u_xlat7.xy = vec2(u_xlati7.xy);
    u_xlat1.xy = u_xlat7.xy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.498039216, 0.498039216);
    SV_Target0.xy = u_xlat1.xy;
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