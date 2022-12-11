//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/DissolveByUV2_Billboard" {
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
  GpuProgramID 19606
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.z = u_xlat15 * in_POSITION0.z;
    u_xlat2.y = 1.0;
    u_xlat4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat2.x = dot(in_NORMAL0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat4.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat2.z = dot(in_NORMAL0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat2.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp float u_xlat10_8;
mediump float u_xlat16_9;
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
    u_xlat16_0.xz = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.x = floor(u_xlat16_0.y);
    u_xlat16_6 = u_xlat16_0.z * 1.04999995 + -0.0500000007;
    u_xlat16_6 = (-u_xlat16_6) + vs_TEXCOORD1.y;
    u_xlat16_6 = u_xlat16_6 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_6 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_9>=0.00999999978);
#else
    u_xlatb1 = u_xlat16_9>=0.00999999978;
#endif
    u_xlat16_9 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_9;
    u_xlat16_6 = (-u_xlat16_6) + u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * _DayColor.w;
    u_xlat1.w = u_xlat16_9 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x + u_xlat16_6;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD5.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat16_3.x = (-u_xlat2.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat8.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xy = texture(_MultiTex, u_xlat2.xy).xy;
    u_xlat10_8 = texture(_MultiTex, u_xlat8.xy).z;
    u_xlat16_5 = (-u_xlat10_2.y) * u_xlat10_8 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_2.xzw = _RColor.xyz * u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_2.xzw + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_2.xyz = texture(_PatternTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _DayColor.xyz * u_xlat16_0.xyz + u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati5;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati5 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati5 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.z = u_xlat16 * in_POSITION0.z;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat4.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat1.x = dot(in_NORMAL0.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat4.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.z = dot(in_NORMAL0.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat4.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat2 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp float u_xlat10_8;
mediump float u_xlat16_9;
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
    u_xlat16_0.xz = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.x = floor(u_xlat16_0.y);
    u_xlat16_6 = u_xlat16_0.z * 1.04999995 + -0.0500000007;
    u_xlat16_6 = (-u_xlat16_6) + vs_TEXCOORD1.y;
    u_xlat16_6 = u_xlat16_6 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_6 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_9>=0.00999999978);
#else
    u_xlatb1 = u_xlat16_9>=0.00999999978;
#endif
    u_xlat16_9 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_9;
    u_xlat16_6 = (-u_xlat16_6) + u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * _DayColor.w;
    u_xlat1.w = u_xlat16_9 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x + u_xlat16_6;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD5.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat16_3.x = (-u_xlat2.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat8.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xy = texture(_MultiTex, u_xlat2.xy).xy;
    u_xlat10_8 = texture(_MultiTex, u_xlat8.xy).z;
    u_xlat16_5 = (-u_xlat10_2.y) * u_xlat10_8 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_2.xzw = _RColor.xyz * u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_2.xzw + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_2.xyz = texture(_PatternTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _DayColor.xyz * u_xlat16_0.xyz + u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.z = u_xlat15 * in_POSITION0.z;
    u_xlat2.y = 1.0;
    u_xlat4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat2.x = dot(in_NORMAL0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat4.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat2.z = dot(in_NORMAL0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat2.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
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
    u_xlat10.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat10.xy).xy;
    u_xlat10.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat10.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_10 = texture(_MultiTex, u_xlat10.xy).z;
    u_xlat16_10 = (-u_xlat10_1.y) * u_xlat10_10 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + u_xlat16_2.xyz;
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
    u_xlat16_12 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_12 = (-u_xlat16_12) + vs_TEXCOORD1.y;
    u_xlat16_12 = u_xlat16_12 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_17>=0.00999999978);
#else
    u_xlatb10 = u_xlat16_17>=0.00999999978;
#endif
    u_xlat16_17 = (u_xlatb10) ? 1.0 : 0.0;
    u_xlat16_7 = floor(u_xlat16_2.y);
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_12) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + u_xlat16_12;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(vs_NORMAL0.xyz, u_xlat3.xyz);
    u_xlat16_7 = (-u_xlat10.x) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 9.99999975e-05);
    u_xlat16_7 = log2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _FresnelPower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_17 * _DayColor.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati5;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati5 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati5 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.z = u_xlat16 * in_POSITION0.z;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat4.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat1.x = dot(in_NORMAL0.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat4.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.z = dot(in_NORMAL0.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat4.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat2 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
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
    u_xlat10.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat10.xy).xy;
    u_xlat10.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat10.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_10 = texture(_MultiTex, u_xlat10.xy).z;
    u_xlat16_10 = (-u_xlat10_1.y) * u_xlat10_10 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + u_xlat16_2.xyz;
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
    u_xlat16_12 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_12 = (-u_xlat16_12) + vs_TEXCOORD1.y;
    u_xlat16_12 = u_xlat16_12 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_17>=0.00999999978);
#else
    u_xlatb10 = u_xlat16_17>=0.00999999978;
#endif
    u_xlat16_17 = (u_xlatb10) ? 1.0 : 0.0;
    u_xlat16_7 = floor(u_xlat16_2.y);
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_12) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + u_xlat16_12;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(vs_NORMAL0.xyz, u_xlat3.xyz);
    u_xlat16_7 = (-u_xlat10.x) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 9.99999975e-05);
    u_xlat16_7 = log2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _FresnelPower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_17 * _DayColor.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.z = u_xlat15 * in_POSITION0.z;
    u_xlat2.y = 1.0;
    u_xlat4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat2.x = dot(in_NORMAL0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat4.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat2.z = dot(in_NORMAL0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat2.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp float u_xlat10_8;
mediump float u_xlat16_9;
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
    u_xlat16_0.xz = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.x = floor(u_xlat16_0.y);
    u_xlat16_6 = u_xlat16_0.z * 1.04999995 + -0.0500000007;
    u_xlat16_6 = (-u_xlat16_6) + vs_TEXCOORD1.y;
    u_xlat16_6 = u_xlat16_6 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_6 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_9>=0.00999999978);
#else
    u_xlatb1 = u_xlat16_9>=0.00999999978;
#endif
    u_xlat16_9 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_9;
    u_xlat16_6 = (-u_xlat16_6) + u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * _DayColor.w;
    u_xlat1.w = u_xlat16_9 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x + u_xlat16_6;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD5.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat16_3.x = (-u_xlat2.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat8.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xy = texture(_MultiTex, u_xlat2.xy).xy;
    u_xlat10_8 = texture(_MultiTex, u_xlat8.xy).z;
    u_xlat16_5 = (-u_xlat10_2.y) * u_xlat10_8 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_2.xzw = _RColor.xyz * u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_2.xzw + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_2.xyz = texture(_PatternTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _DayColor.xyz * u_xlat16_0.xyz + u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati5;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati5 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati5 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.z = u_xlat16 * in_POSITION0.z;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat4.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat1.x = dot(in_NORMAL0.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat4.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.z = dot(in_NORMAL0.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat4.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat2 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
lowp float u_xlat10_8;
mediump float u_xlat16_9;
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
    u_xlat16_0.xz = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.x = floor(u_xlat16_0.y);
    u_xlat16_6 = u_xlat16_0.z * 1.04999995 + -0.0500000007;
    u_xlat16_6 = (-u_xlat16_6) + vs_TEXCOORD1.y;
    u_xlat16_6 = u_xlat16_6 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_6 * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat16_9>=0.00999999978);
#else
    u_xlatb1 = u_xlat16_9>=0.00999999978;
#endif
    u_xlat16_9 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_9;
    u_xlat16_6 = (-u_xlat16_6) + u_xlat16_9;
    u_xlat16_9 = u_xlat16_9 * _DayColor.w;
    u_xlat1.w = u_xlat16_9 * _AlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x + u_xlat16_6;
    u_xlat2.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD5.xyz;
    u_xlat2.x = dot(vs_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat16_3.x = (-u_xlat2.x) + 1.0;
    u_xlat16_3.x = max(u_xlat16_3.x, 9.99999975e-05);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _FresnelPower;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_0.x = u_xlat16_3.x + u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat8.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat2.xy;
    u_xlat10_2.xy = texture(_MultiTex, u_xlat2.xy).xy;
    u_xlat10_8 = texture(_MultiTex, u_xlat8.xy).z;
    u_xlat16_5 = (-u_xlat10_2.y) * u_xlat10_8 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat16_2.xzw = _RColor.xyz * u_xlat10_2.xxx + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_2.xzw + u_xlat16_3.xyz;
    u_xlat16_3.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _PatternTex_ST.xy + _PatternTex_ST.zw;
    u_xlat10_2.xyz = texture(_PatternTex, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = _DayColor.xyz * u_xlat16_0.xyz + u_xlat10_2.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.x = u_xlat15 * in_POSITION0.x;
    u_xlat15 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat0.z = u_xlat15 * in_POSITION0.z;
    u_xlat2.y = 1.0;
    u_xlat4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat4.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat2.x = dot(in_NORMAL0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat4.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat2.z = dot(in_NORMAL0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat4.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat2.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
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
    u_xlat10.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat10.xy).xy;
    u_xlat10.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat10.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_10 = texture(_MultiTex, u_xlat10.xy).z;
    u_xlat16_10 = (-u_xlat10_1.y) * u_xlat10_10 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + u_xlat16_2.xyz;
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
    u_xlat16_12 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_12 = (-u_xlat16_12) + vs_TEXCOORD1.y;
    u_xlat16_12 = u_xlat16_12 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_17>=0.00999999978);
#else
    u_xlatb10 = u_xlat16_17>=0.00999999978;
#endif
    u_xlat16_17 = (u_xlatb10) ? 1.0 : 0.0;
    u_xlat16_7 = floor(u_xlat16_2.y);
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_12) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + u_xlat16_12;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(vs_NORMAL0.xyz, u_xlat3.xyz);
    u_xlat16_7 = (-u_xlat10.x) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 9.99999975e-05);
    u_xlat16_7 = log2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _FresnelPower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_17 * _DayColor.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
int u_xlati5;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5 = inversesqrt(u_xlat5);
    u_xlat2.xyz = vec3(u_xlat5) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati5 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = u_xlati5 << 3;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.y = u_xlat16 * in_POSITION0.y;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.x = u_xlat16 * in_POSITION0.x;
    u_xlat16 = dot(unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat3.z = u_xlat16 * in_POSITION0.z;
    u_xlat4.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat4.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat1.x = dot(in_NORMAL0.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat4.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat1.z = dot(in_NORMAL0.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat4.xyz + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat2.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat2.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat2.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat2 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD5.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_NORMAL0.xyz = u_xlat0.xxx * u_xlat1.xyz;
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
in highp vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec2 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
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
    u_xlat10.xy = vs_TEXCOORD0.xy * _MultiTex_ST.xy + _MultiTex_ST.zw;
    u_xlat10_1.xy = texture(_MultiTex, u_xlat10.xy).xy;
    u_xlat10.xy = _Time.yy * _MultiTexBPannerXY.xy + u_xlat10.xy;
    u_xlat16_2.xyz = _GGlowColor.xyz * vec3(_GGlowColorScale);
    u_xlat10_10 = texture(_MultiTex, u_xlat10.xy).z;
    u_xlat16_10 = (-u_xlat10_1.y) * u_xlat10_10 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _RColor.xyz * u_xlat10_1.xxx + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz + u_xlat16_2.xyz;
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
    u_xlat16_12 = u_xlat16_2.z * 1.04999995 + -0.0500000007;
    u_xlat16_12 = (-u_xlat16_12) + vs_TEXCOORD1.y;
    u_xlat16_12 = u_xlat16_12 * 20.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_12 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat16_17>=0.00999999978);
#else
    u_xlatb10 = u_xlat16_17>=0.00999999978;
#endif
    u_xlat16_17 = (u_xlatb10) ? 1.0 : 0.0;
    u_xlat16_7 = floor(u_xlat16_2.y);
    u_xlat16_12 = (-u_xlat16_12) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_2.x) + u_xlat16_17;
    u_xlat16_2.x = (-u_xlat16_12) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_7 * u_xlat16_2.x + u_xlat16_12;
    u_xlat10.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat3.xyz = u_xlat10.xxx * vs_TEXCOORD5.xyz;
    u_xlat10.x = dot(vs_NORMAL0.xyz, u_xlat3.xyz);
    u_xlat16_7 = (-u_xlat10.x) + 1.0;
    u_xlat16_7 = max(u_xlat16_7, 9.99999975e-05);
    u_xlat16_7 = log2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _FresnelPower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = _DissolveOutlineColor.xyz * vec3(_DissolveOutlineColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture(_PatternTex, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = _DayColor.xyz * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * vec3(vec3(_ColorBrightness, _ColorBrightness, _ColorBrightness));
    u_xlat16_2.x = u_xlat16_17 * _DayColor.w;
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
  GpuProgramID 75462
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
  GpuProgramID 175775
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[1].xyz, hlslcc_mtx4x4unity_ObjectToWorld[1].xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.y = u_xlat0.x * in_POSITION0.y;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz);
    u_xlat2.z = u_xlat1.y;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    u_xlat2.x = u_xlat3.y;
    u_xlat2.y = 1.0;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.x = u_xlat12 * in_POSITION0.x;
    u_xlat12 = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat12 = sqrt(u_xlat12);
    u_xlat0.z = u_xlat12 * in_POSITION0.z;
    u_xlat2.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat3.w = u_xlat1.x;
    u_xlat2.x = dot(u_xlat0.xz, u_xlat3.xw);
    u_xlat1.w = u_xlat3.z;
    u_xlat2.z = dot(u_xlat0.zx, u_xlat1.zw);
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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

uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
vec3 u_xlat3;
float u_xlat4;
int u_xlati4;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz);
    u_xlat1.z = u_xlat0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat4 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat2.xyz = vec3(u_xlat4) * u_xlat2.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat1.y = 1.0;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.y = u_xlat13 * in_POSITION0.y;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.x = u_xlat13 * in_POSITION0.x;
    u_xlat13 = dot(unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat3.z = u_xlat13 * in_POSITION0.z;
    u_xlat1.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat2.w = u_xlat0.x;
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xw);
    u_xlat0.w = u_xlat2.z;
    u_xlat1.z = dot(u_xlat3.zx, u_xlat0.zw);
    u_xlat0.xzw = u_xlat1.xyz + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz;
    u_xlat1.xyz = u_xlat0.zzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat1 = u_xlat0.zzzz * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat2.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    gl_Position.z = u_xlat2.x * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_NonJitteredVP[1];
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_NonJitteredVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD3 = hlslcc_mtx4x4_NonJitteredVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4_PreviousVP[1];
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_PreviousVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD4 = hlslcc_mtx4x4_PreviousVP[3] * u_xlat0.wwww + u_xlat1;
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