//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/LotterySkybox" {
Properties {
_SkyColor ("Sky Color", Color) = (0.426273,0.3749459,0.6985294,0)
_SkyLine ("SkyLine", Color) = (1,1,1,0)
_AtmosphericColor ("Atmospheric Color", Color) = (0.1609537,0.07028547,0.1911765,0)
_Opacity ("Opacity", Range(0, 1)) = 0
_AtmosphericScale ("Atmospheric Scale", Float) = 1
_SkyLinePower ("SkyLinePower", Float) = 23.16
_AtmosphericPower ("Atmospheric Power", Float) = 1
[Toggle(_SKYTEXANDCOLOR_ON)] _SkyTexAndColor ("SkyTex And Color", Float) = 0
_SkyGradient ("SkyGradient", 2D) = "white" { }
_ColorBirghtness ("Color Birghtness", Float) = 1
_SkyGradientColor ("SkyGradientColor", Color) = (1,1,1,0)
_ColorDesaturate ("ColorDesaturate", Float) = 0
_CloudMap ("CloudMap", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _CloudMapChannel ("CloudMapChannel", Float) = 0
_CloudColor ("CloudColor", Color) = (1,1,1,0)
_CloudBrightness ("CloudBrightness", Float) = 0
_CloudSpeedU ("CloudSpeedU", Float) = 0
_CloudSpeedV ("CloudSpeedV", Float) = 0
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
  GpuProgramID 19958
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SKYTEXANDCOLOR_ON" }
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_1.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_5 = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericPower;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SkyLinePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _AtmosphericColor.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_1.xyz = vec3(_ColorDesaturate) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb2 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_13 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_13 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_13;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_1.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_5 = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericPower;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SkyLinePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _AtmosphericColor.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_1.xyz = vec3(_ColorDesaturate) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb2 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_13 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_13 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_13;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SKYTEXANDCOLOR_ON" }
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_6.x = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericPower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat4.xyz = u_xlat16_6.xxx * u_xlat4.xyz + _AtmosphericColor.xyz;
    u_xlat16_6.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SkyLinePower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat1.xyz = (-u_xlat4.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_6.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_6.x = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericPower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat4.xyz = u_xlat16_6.xxx * u_xlat4.xyz + _AtmosphericColor.xyz;
    u_xlat16_6.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SkyLinePower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat1.xyz = (-u_xlat4.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_6.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SKYTEXANDCOLOR_ON" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_1.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_5 = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericPower;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SkyLinePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _AtmosphericColor.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_1.xyz = vec3(_ColorDesaturate) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb2 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_13 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_13 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_13;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_1.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_5 = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_5 = log2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericPower;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SkyLinePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat0.xyz = vec3(u_xlat16_5) * u_xlat0.xyz + _AtmosphericColor.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_1.xxx * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_1.xyz = vec3(_ColorDesaturate) * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb2 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_13 = (u_xlatb2.w) ? u_xlat0.w : 0.0;
    u_xlat16_13 = (u_xlatb2.z) ? u_xlat0.z : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.y) ? u_xlat0.y : u_xlat16_13;
    u_xlat16_13 = (u_xlatb2.x) ? u_xlat0.x : u_xlat16_13;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump vec4 _SkyGradientColor;
uniform 	mediump float _ColorBirghtness;
uniform 	vec4 _SkyGradient_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
uniform lowp sampler2D _SkyGradient;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SkyGradient_ST.xy + _SkyGradient_ST.zw;
    u_xlat16_6.xyz = _SkyGradientColor.xyz * vec3(_ColorBirghtness);
    u_xlat10_0.xyz = texture(_SkyGradient, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * u_xlat10_0.xyz + vec3(u_xlat16_12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SKYTEXANDCOLOR_ON" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_6.x = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericPower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat4.xyz = u_xlat16_6.xxx * u_xlat4.xyz + _AtmosphericColor.xyz;
    u_xlat16_6.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SkyLinePower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat1.xyz = (-u_xlat4.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_6.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _Time;
uniform 	vec4 unity_DebugViewInfo;
uniform 	mediump vec4 _CloudColor;
uniform 	mediump float _CloudBrightness;
uniform 	mediump float _CloudMapChannel;
uniform 	mediump float _CloudSpeedU;
uniform 	mediump float _CloudSpeedV;
uniform 	vec4 _CloudMap_ST;
uniform 	mediump float _ColorDesaturate;
uniform 	vec4 _AtmosphericColor;
uniform 	vec4 _SkyColor;
uniform 	mediump float _AtmosphericPower;
uniform 	mediump float _AtmosphericScale;
uniform 	mediump vec4 _SkyLine;
uniform 	mediump float _SkyLinePower;
uniform 	float _Opacity;
uniform lowp sampler2D _CloudMap;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_6;
float u_xlat12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudMap_ST.xy + _CloudMap_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeedU, _CloudSpeedV) + u_xlat0.xy;
    u_xlat0 = texture(_CloudMap, u_xlat0.xy);
    u_xlatb1 = equal(vec4(vec4(_CloudMapChannel, _CloudMapChannel, _CloudMapChannel, _CloudMapChannel)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat16_2 = (u_xlatb1.w) ? u_xlat0.w : 0.0;
    u_xlat16_2 = (u_xlatb1.z) ? u_xlat0.z : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.y) ? u_xlat0.y : u_xlat16_2;
    u_xlat16_2 = (u_xlatb1.x) ? u_xlat0.x : u_xlat16_2;
    u_xlat16_0 = vs_TEXCOORD0.y + -0.5;
    u_xlat16_6.x = max(abs(u_xlat16_0), 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericPower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _AtmosphericScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_AtmosphericColor.xyz) + _SkyColor.xyz;
    u_xlat4.xyz = u_xlat16_6.xxx * u_xlat4.xyz + _AtmosphericColor.xyz;
    u_xlat16_6.x = -abs(u_xlat16_0) + 1.0;
    u_xlat16_6.x = max(u_xlat16_6.x, 9.99999975e-05);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_6.x * _SkyLinePower;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat1.xyz = (-u_xlat4.xyz) + _SkyLine.xyz;
    u_xlat0.xyz = u_xlat16_6.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat16_6.xyz = vec3(_ColorDesaturate) * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat16_3.xyz = _CloudColor.xyz * vec3(_CloudBrightness);
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_2) + u_xlat16_6.xyz;
    SV_Target0.w = _Opacity;
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
Keywords { "_SKYTEXANDCOLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_SKYTEXANDCOLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
Keywords { "FOG_HEIGHT" "_SKYTEXANDCOLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
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
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SKYTEXANDCOLOR_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SKYTEXANDCOLOR_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}