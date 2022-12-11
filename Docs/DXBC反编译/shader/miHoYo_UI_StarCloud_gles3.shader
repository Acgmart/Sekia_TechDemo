//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/UI/StarCloud" {
Properties {
_CloudColor ("CloudColor", Color) = (0,1,0.7103448,0)
_CloudTex ("CloudTex", 2D) = "white" { }
_CloudOffset ("CloudOffset", Float) = 0
_CloudTexUV2Coord ("CloudTexUV2Coord", Vector) = (1,1,0,0)
_StarDepth ("StarDepth", Float) = 14.89
_CloudMultiplyer ("CloudMultiplyer", Float) = 2.5
_CloudSpeed ("CloudSpeed", Float) = 0.05
_Cloud02Color ("Cloud02Color", Color) = (1,0.3676471,0.3676471,0)
_Cloud02Tex ("Cloud02Tex", 2D) = "white" { }
_CloudTex02UV2Coord ("CloudTex02UV2Coord", Vector) = (1,1,0,0)
_Cloud02Offset ("Cloud02Offset", Float) = -0.09
_Cloud02Multipler ("Cloud02Multipler", Float) = 2.5
_Cloud02Speed ("Cloud02Speed", Float) = 0.005
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseTexUV2Coord ("NoiseTexUV2Coord", Vector) = (1,1,0,0)
_NoiseOffset ("NoiseOffset", Float) = 0.08
_NoiseBrightness ("NoiseBrightness", Float) = 3.01
_NoiseSpeed ("NoiseSpeed", Float) = 0.01
_StarBrightness ("StarBrightness", Float) = 10
_StarTex ("StarTex", 2D) = "black" { }
_StarUVSpeed ("StarUVSpeed", Float) = 1
_StarTexUV2Coord ("StarTexUV2Coord", Vector) = (1,1,0,0)
_ColorPalette ("ColorPalette", 2D) = "white" { }
_Desaturate ("Desaturate", Range(0, 1)) = 0
_ColorPalletteSpeed ("ColorPalletteSpeed", Float) = -1.95
_FadeAlpha ("FadeAlpha", Range(0, 1)) = 1
_Power ("Power", Float) = 10
_Scale ("Scale", Float) = 33.58
_HorizonFade ("HorizonFade", Float) = 4
_HorizonHeight ("HorizonHeight", Float) = -1.95
_GradientRange ("GradientRange", Float) = 8
_GradientOffset ("GradientOffset", Float) = -6
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
  GpuProgramID 11331
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1.z = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat3.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat7;
float u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
float u_xlat19;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Cloud02Speed;
    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + u_xlat0.xx;
    u_xlat10_0 = texture(_Cloud02Tex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat6.xy;
    u_xlat10_6 = texture(_Cloud02Tex, u_xlat6.xy).x;
    u_xlat16_0 = (-u_xlat10_6) + u_xlat10_0;
    u_xlat12 = _GradientRange + _GradientOffset;
    u_xlat12 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat18) + u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x + u_xlat18;
    u_xlat0.x = u_xlat12 * u_xlat16_0 + u_xlat10_6;
    u_xlat6.x = u_xlat0.x + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * _Cloud02Color.xyz;
    u_xlat6.x = _Time.y * _CloudSpeed;
    u_xlat6.xz = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + u_xlat6.xx;
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xz).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat2.xy;
    u_xlat10_18 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat18 = u_xlat6.x + _CloudOffset;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat16_4.xyz + u_xlat10_3.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_5.xyz = (-u_xlat3.xyz) + u_xlat6.xxx;
    u_xlat16_5.xyz = vec3(_Desaturate) * u_xlat16_5.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_5.xyz + (-u_xlat2.xyz);
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_6 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_18 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.x = u_xlat6.x + _NoiseOffset;
    u_xlat6.x = u_xlat6.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xz = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat19 = _StarDepth + -1.0;
    u_xlat6.xz = u_xlat6.xz * vec2(u_xlat19);
    u_xlat2.xy = u_xlat6.xz * vec2(-0.100000001, -0.100000001);
    u_xlat3.zw = u_xlat2.xy;
    u_xlat16_23 = _StarUVSpeed + -0.00999999978;
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat4.x = _Time.y * u_xlat16_23 + u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat6.xz = vec2(u_xlat3.z + u_xlat4.x, u_xlat3.y + u_xlat4.y);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat6.xz = vec2(u_xlat6.x + u_xlat3.z, u_xlat6.z + u_xlat3.w);
    u_xlat10_6 = texture(_StarTex, u_xlat6.xz).x;
    u_xlat2.zw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _StarUVSpeed + u_xlat2.z;
    u_xlat2.xy = u_xlat2.xw + u_xlat3.xy;
    u_xlat2.xy = vec2(u_xlat2.x + u_xlat3.z, u_xlat2.y + u_xlat3.w);
    u_xlat10_18 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.xyz = u_xlat16_5.xyz * u_xlat6.xxx;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Scale;
    u_xlat7 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat7 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _FadeAlpha;
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
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    u_xlat5.z = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat7;
float u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
float u_xlat19;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Cloud02Speed;
    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + u_xlat0.xx;
    u_xlat10_0 = texture(_Cloud02Tex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat6.xy;
    u_xlat10_6 = texture(_Cloud02Tex, u_xlat6.xy).x;
    u_xlat16_0 = (-u_xlat10_6) + u_xlat10_0;
    u_xlat12 = _GradientRange + _GradientOffset;
    u_xlat12 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat18) + u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x + u_xlat18;
    u_xlat0.x = u_xlat12 * u_xlat16_0 + u_xlat10_6;
    u_xlat6.x = u_xlat0.x + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * _Cloud02Color.xyz;
    u_xlat6.x = _Time.y * _CloudSpeed;
    u_xlat6.xz = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + u_xlat6.xx;
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xz).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat2.xy;
    u_xlat10_18 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat18 = u_xlat6.x + _CloudOffset;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat16_4.xyz + u_xlat10_3.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_5.xyz = (-u_xlat3.xyz) + u_xlat6.xxx;
    u_xlat16_5.xyz = vec3(_Desaturate) * u_xlat16_5.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_5.xyz + (-u_xlat2.xyz);
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_6 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_18 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.x = u_xlat6.x + _NoiseOffset;
    u_xlat6.x = u_xlat6.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xz = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat19 = _StarDepth + -1.0;
    u_xlat6.xz = u_xlat6.xz * vec2(u_xlat19);
    u_xlat2.xy = u_xlat6.xz * vec2(-0.100000001, -0.100000001);
    u_xlat3.zw = u_xlat2.xy;
    u_xlat16_23 = _StarUVSpeed + -0.00999999978;
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat4.x = _Time.y * u_xlat16_23 + u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat6.xz = vec2(u_xlat3.z + u_xlat4.x, u_xlat3.y + u_xlat4.y);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat6.xz = vec2(u_xlat6.x + u_xlat3.z, u_xlat6.z + u_xlat3.w);
    u_xlat10_6 = texture(_StarTex, u_xlat6.xz).x;
    u_xlat2.zw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _StarUVSpeed + u_xlat2.z;
    u_xlat2.xy = u_xlat2.xw + u_xlat3.xy;
    u_xlat2.xy = vec2(u_xlat2.x + u_xlat3.z, u_xlat2.y + u_xlat3.w);
    u_xlat10_18 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.xyz = u_xlat16_5.xyz * u_xlat6.xxx;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Scale;
    u_xlat7 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat7 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _FadeAlpha;
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
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
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
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1.z = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat3.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_19;
lowp float u_xlat10_19;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12 = _Time.y * _CloudSpeed;
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = _GradientRange + _GradientOffset;
    u_xlat1.x = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = u_xlat1.x * u_xlat7.x + u_xlat18;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + vec2(u_xlat12);
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_0) + u_xlat10_6;
    u_xlat0.x = u_xlat18 * u_xlat16_6 + u_xlat10_0;
    u_xlat6.x = u_xlat0.x + _CloudOffset;
    u_xlat6.x = u_xlat6.x * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat12 = _Time.y * _Cloud02Speed;
    u_xlat1.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat1.xy).x;
    u_xlat7.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + vec2(u_xlat12);
    u_xlat10_12 = texture(_Cloud02Tex, u_xlat7.xy).x;
    u_xlat16_12 = (-u_xlat10_1) + u_xlat10_12;
    u_xlat12 = u_xlat18 * u_xlat16_12 + u_xlat10_1;
    u_xlat1.x = u_xlat12 + _Cloud02Offset;
    u_xlat1.x = u_xlat1.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat2.x = _Time.y * _ColorPalletteSpeed + u_xlat2.y;
    u_xlat10_7.xyz = texture(_ColorPalette, u_xlat2.xz).xyz;
    u_xlat16_2.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat10_7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat7.xyz) + u_xlat2.xxx;
    u_xlat16_3.xyz = vec3(_Desaturate) * u_xlat16_3.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat4.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat4.z = _Time.y * _NoiseSpeed + u_xlat4.y;
    u_xlat10_7.x = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat10_13 = texture(_NoiseTex, u_xlat4.xz).x;
    u_xlat16_13 = (-u_xlat10_7.x) + u_xlat10_13;
    u_xlat7.x = u_xlat18 * u_xlat16_13 + u_xlat10_7.x;
    u_xlat7.x = u_xlat7.x + _NoiseOffset;
    u_xlat7.x = u_xlat7.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _Cloud02Color.xyz;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat2.yw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat4.x = _Time.y * _StarUVSpeed + u_xlat2.y;
    u_xlat4.y = float(0.0);
    u_xlat16.x = float(1.0);
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xy = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat6.x = _StarDepth + -1.0;
    u_xlat5.xy = u_xlat5.xy * u_xlat6.xx;
    u_xlat2.xz = u_xlat5.yx * vec2(-0.100000001, -0.100000001);
    u_xlat4.xy = vec2(u_xlat2.z + u_xlat4.x, u_xlat2.w + u_xlat4.y);
    u_xlat16.y = u_xlat2.x;
    u_xlat4.xy = u_xlat4.xy + u_xlat16.xy;
    u_xlat2.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat16_21 = _StarUVSpeed + -0.00999999978;
    u_xlat5.x = _Time.y * u_xlat16_21 + u_xlat2.x;
    u_xlat5.y = 0.0;
    u_xlat2.xy = vec2(u_xlat2.z + u_xlat5.x, u_xlat2.y + u_xlat5.y);
    u_xlat2.xy = u_xlat2.xy + u_xlat16.xy;
    u_xlat10_6 = texture(_StarTex, u_xlat4.xy).x;
    u_xlat10_19 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_19 = (-u_xlat10_6) + u_xlat10_19;
    u_xlat6.x = u_xlat18 * u_xlat16_19 + u_xlat10_6;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD6.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat19 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Scale;
    u_xlat18 = u_xlat19 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_3.xyz * u_xlat6.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.w = u_xlat18 * _FadeAlpha;
    SV_Target0 = u_xlat1;
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
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    u_xlat5.z = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_19;
lowp float u_xlat10_19;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12 = _Time.y * _CloudSpeed;
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = _GradientRange + _GradientOffset;
    u_xlat1.x = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = u_xlat1.x * u_xlat7.x + u_xlat18;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + vec2(u_xlat12);
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_0) + u_xlat10_6;
    u_xlat0.x = u_xlat18 * u_xlat16_6 + u_xlat10_0;
    u_xlat6.x = u_xlat0.x + _CloudOffset;
    u_xlat6.x = u_xlat6.x * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat12 = _Time.y * _Cloud02Speed;
    u_xlat1.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat1.xy).x;
    u_xlat7.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + vec2(u_xlat12);
    u_xlat10_12 = texture(_Cloud02Tex, u_xlat7.xy).x;
    u_xlat16_12 = (-u_xlat10_1) + u_xlat10_12;
    u_xlat12 = u_xlat18 * u_xlat16_12 + u_xlat10_1;
    u_xlat1.x = u_xlat12 + _Cloud02Offset;
    u_xlat1.x = u_xlat1.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat2.x = _Time.y * _ColorPalletteSpeed + u_xlat2.y;
    u_xlat10_7.xyz = texture(_ColorPalette, u_xlat2.xz).xyz;
    u_xlat16_2.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat10_7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat7.xyz) + u_xlat2.xxx;
    u_xlat16_3.xyz = vec3(_Desaturate) * u_xlat16_3.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat4.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat4.z = _Time.y * _NoiseSpeed + u_xlat4.y;
    u_xlat10_7.x = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat10_13 = texture(_NoiseTex, u_xlat4.xz).x;
    u_xlat16_13 = (-u_xlat10_7.x) + u_xlat10_13;
    u_xlat7.x = u_xlat18 * u_xlat16_13 + u_xlat10_7.x;
    u_xlat7.x = u_xlat7.x + _NoiseOffset;
    u_xlat7.x = u_xlat7.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _Cloud02Color.xyz;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat2.yw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat4.x = _Time.y * _StarUVSpeed + u_xlat2.y;
    u_xlat4.y = float(0.0);
    u_xlat16.x = float(1.0);
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xy = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat6.x = _StarDepth + -1.0;
    u_xlat5.xy = u_xlat5.xy * u_xlat6.xx;
    u_xlat2.xz = u_xlat5.yx * vec2(-0.100000001, -0.100000001);
    u_xlat4.xy = vec2(u_xlat2.z + u_xlat4.x, u_xlat2.w + u_xlat4.y);
    u_xlat16.y = u_xlat2.x;
    u_xlat4.xy = u_xlat4.xy + u_xlat16.xy;
    u_xlat2.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat16_21 = _StarUVSpeed + -0.00999999978;
    u_xlat5.x = _Time.y * u_xlat16_21 + u_xlat2.x;
    u_xlat5.y = 0.0;
    u_xlat2.xy = vec2(u_xlat2.z + u_xlat5.x, u_xlat2.y + u_xlat5.y);
    u_xlat2.xy = u_xlat2.xy + u_xlat16.xy;
    u_xlat10_6 = texture(_StarTex, u_xlat4.xy).x;
    u_xlat10_19 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_19 = (-u_xlat10_6) + u_xlat10_19;
    u_xlat6.x = u_xlat18 * u_xlat16_19 + u_xlat10_6;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD6.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat19 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Scale;
    u_xlat18 = u_xlat19 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_3.xyz * u_xlat6.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.w = u_xlat18 * _FadeAlpha;
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

uniform 	vec3 _WorldSpaceCameraPos;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1.z = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat3.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat7;
float u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
float u_xlat19;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Cloud02Speed;
    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + u_xlat0.xx;
    u_xlat10_0 = texture(_Cloud02Tex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat6.xy;
    u_xlat10_6 = texture(_Cloud02Tex, u_xlat6.xy).x;
    u_xlat16_0 = (-u_xlat10_6) + u_xlat10_0;
    u_xlat12 = _GradientRange + _GradientOffset;
    u_xlat12 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat18) + u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x + u_xlat18;
    u_xlat0.x = u_xlat12 * u_xlat16_0 + u_xlat10_6;
    u_xlat6.x = u_xlat0.x + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * _Cloud02Color.xyz;
    u_xlat6.x = _Time.y * _CloudSpeed;
    u_xlat6.xz = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + u_xlat6.xx;
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xz).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat2.xy;
    u_xlat10_18 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat18 = u_xlat6.x + _CloudOffset;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat16_4.xyz + u_xlat10_3.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_5.xyz = (-u_xlat3.xyz) + u_xlat6.xxx;
    u_xlat16_5.xyz = vec3(_Desaturate) * u_xlat16_5.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_5.xyz + (-u_xlat2.xyz);
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_6 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_18 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.x = u_xlat6.x + _NoiseOffset;
    u_xlat6.x = u_xlat6.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xz = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat19 = _StarDepth + -1.0;
    u_xlat6.xz = u_xlat6.xz * vec2(u_xlat19);
    u_xlat2.xy = u_xlat6.xz * vec2(-0.100000001, -0.100000001);
    u_xlat3.zw = u_xlat2.xy;
    u_xlat16_23 = _StarUVSpeed + -0.00999999978;
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat4.x = _Time.y * u_xlat16_23 + u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat6.xz = vec2(u_xlat3.z + u_xlat4.x, u_xlat3.y + u_xlat4.y);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat6.xz = vec2(u_xlat6.x + u_xlat3.z, u_xlat6.z + u_xlat3.w);
    u_xlat10_6 = texture(_StarTex, u_xlat6.xz).x;
    u_xlat2.zw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _StarUVSpeed + u_xlat2.z;
    u_xlat2.xy = u_xlat2.xw + u_xlat3.xy;
    u_xlat2.xy = vec2(u_xlat2.x + u_xlat3.z, u_xlat2.y + u_xlat3.w);
    u_xlat10_18 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.xyz = u_xlat16_5.xyz * u_xlat6.xxx;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Scale;
    u_xlat7 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat7 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _FadeAlpha;
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
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    u_xlat5.z = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
float u_xlat7;
float u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
float u_xlat19;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Cloud02Speed;
    u_xlat0.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + u_xlat0.xx;
    u_xlat10_0 = texture(_Cloud02Tex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat6.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat6.xy;
    u_xlat10_6 = texture(_Cloud02Tex, u_xlat6.xy).x;
    u_xlat16_0 = (-u_xlat10_6) + u_xlat10_0;
    u_xlat12 = _GradientRange + _GradientOffset;
    u_xlat12 = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat18) + u_xlat12;
    u_xlat12 = u_xlat12 * u_xlat1.x + u_xlat18;
    u_xlat0.x = u_xlat12 * u_xlat16_0 + u_xlat10_6;
    u_xlat6.x = u_xlat0.x + _Cloud02Offset;
    u_xlat6.x = u_xlat6.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * _Cloud02Color.xyz;
    u_xlat6.x = _Time.y * _CloudSpeed;
    u_xlat6.xz = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + u_xlat6.xx;
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xz).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat2.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat2.xy;
    u_xlat10_18 = texture(_CloudTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat18 = u_xlat6.x + _CloudOffset;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat6.x = u_xlat18 * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat3.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat3.x = _Time.y * _ColorPalletteSpeed + u_xlat3.y;
    u_xlat10_3.xyz = texture(_ColorPalette, u_xlat3.xz).xyz;
    u_xlat16_4.xyz = (-u_xlat10_3.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat16_4.xyz + u_xlat10_3.xyz;
    u_xlat6.x = dot(u_xlat3.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_5.xyz = (-u_xlat3.xyz) + u_xlat6.xxx;
    u_xlat16_5.xyz = vec3(_Desaturate) * u_xlat16_5.xyz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_5.xyz + (-u_xlat2.xyz);
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_6 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = _Time.y * _NoiseSpeed + u_xlat3.y;
    u_xlat10_18 = texture(_NoiseTex, u_xlat3.xz).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.x = u_xlat6.x + _NoiseOffset;
    u_xlat6.x = u_xlat6.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xz = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat19 = _StarDepth + -1.0;
    u_xlat6.xz = u_xlat6.xz * vec2(u_xlat19);
    u_xlat2.xy = u_xlat6.xz * vec2(-0.100000001, -0.100000001);
    u_xlat3.zw = u_xlat2.xy;
    u_xlat16_23 = _StarUVSpeed + -0.00999999978;
    u_xlat3.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat4.x = _Time.y * u_xlat16_23 + u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat6.xz = vec2(u_xlat3.z + u_xlat4.x, u_xlat3.y + u_xlat4.y);
    u_xlat3.y = float(0.0);
    u_xlat3.z = float(1.0);
    u_xlat6.xz = vec2(u_xlat6.x + u_xlat3.z, u_xlat6.z + u_xlat3.w);
    u_xlat10_6 = texture(_StarTex, u_xlat6.xz).x;
    u_xlat2.zw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat3.x = _Time.y * _StarUVSpeed + u_xlat2.z;
    u_xlat2.xy = u_xlat2.xw + u_xlat3.xy;
    u_xlat2.xy = vec2(u_xlat2.x + u_xlat3.z, u_xlat2.y + u_xlat3.w);
    u_xlat10_18 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_6 = (-u_xlat10_18) + u_xlat10_6;
    u_xlat6.x = u_xlat12 * u_xlat16_6 + u_xlat10_18;
    u_xlat6.xyz = u_xlat16_5.xyz * u_xlat6.xxx;
    u_xlat6.xyz = u_xlat6.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD5.xyz;
    u_xlat19 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * vs_TEXCOORD6.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Power;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _Scale;
    u_xlat7 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat7 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1.x * _FadeAlpha;
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
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat15;
float u_xlat16;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.yxz;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.yxz * u_xlat2.zxy;
    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.xzy + (-u_xlat3.xyz);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.yxz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.x = u_xlat1.y;
    u_xlat4.z = u_xlat2.y;
    u_xlat4.xyz = u_xlat0.yyy * u_xlat4.xyz;
    u_xlat1.y = u_xlat3.z;
    u_xlat3.x = u_xlat1.z;
    u_xlat3.z = u_xlat2.x;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat1.z = u_xlat2.z;
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat0.zzz + u_xlat3.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_19;
lowp float u_xlat10_19;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12 = _Time.y * _CloudSpeed;
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = _GradientRange + _GradientOffset;
    u_xlat1.x = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = u_xlat1.x * u_xlat7.x + u_xlat18;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + vec2(u_xlat12);
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_0) + u_xlat10_6;
    u_xlat0.x = u_xlat18 * u_xlat16_6 + u_xlat10_0;
    u_xlat6.x = u_xlat0.x + _CloudOffset;
    u_xlat6.x = u_xlat6.x * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat12 = _Time.y * _Cloud02Speed;
    u_xlat1.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat1.xy).x;
    u_xlat7.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + vec2(u_xlat12);
    u_xlat10_12 = texture(_Cloud02Tex, u_xlat7.xy).x;
    u_xlat16_12 = (-u_xlat10_1) + u_xlat10_12;
    u_xlat12 = u_xlat18 * u_xlat16_12 + u_xlat10_1;
    u_xlat1.x = u_xlat12 + _Cloud02Offset;
    u_xlat1.x = u_xlat1.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat2.x = _Time.y * _ColorPalletteSpeed + u_xlat2.y;
    u_xlat10_7.xyz = texture(_ColorPalette, u_xlat2.xz).xyz;
    u_xlat16_2.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat10_7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat7.xyz) + u_xlat2.xxx;
    u_xlat16_3.xyz = vec3(_Desaturate) * u_xlat16_3.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat4.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat4.z = _Time.y * _NoiseSpeed + u_xlat4.y;
    u_xlat10_7.x = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat10_13 = texture(_NoiseTex, u_xlat4.xz).x;
    u_xlat16_13 = (-u_xlat10_7.x) + u_xlat10_13;
    u_xlat7.x = u_xlat18 * u_xlat16_13 + u_xlat10_7.x;
    u_xlat7.x = u_xlat7.x + _NoiseOffset;
    u_xlat7.x = u_xlat7.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _Cloud02Color.xyz;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat2.yw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat4.x = _Time.y * _StarUVSpeed + u_xlat2.y;
    u_xlat4.y = float(0.0);
    u_xlat16.x = float(1.0);
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xy = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat6.x = _StarDepth + -1.0;
    u_xlat5.xy = u_xlat5.xy * u_xlat6.xx;
    u_xlat2.xz = u_xlat5.yx * vec2(-0.100000001, -0.100000001);
    u_xlat4.xy = vec2(u_xlat2.z + u_xlat4.x, u_xlat2.w + u_xlat4.y);
    u_xlat16.y = u_xlat2.x;
    u_xlat4.xy = u_xlat4.xy + u_xlat16.xy;
    u_xlat2.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat16_21 = _StarUVSpeed + -0.00999999978;
    u_xlat5.x = _Time.y * u_xlat16_21 + u_xlat2.x;
    u_xlat5.y = 0.0;
    u_xlat2.xy = vec2(u_xlat2.z + u_xlat5.x, u_xlat2.y + u_xlat5.y);
    u_xlat2.xy = u_xlat2.xy + u_xlat16.xy;
    u_xlat10_6 = texture(_StarTex, u_xlat4.xy).x;
    u_xlat10_19 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_19 = (-u_xlat10_6) + u_xlat10_19;
    u_xlat6.x = u_xlat18 * u_xlat16_19 + u_xlat10_6;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD6.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat19 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Scale;
    u_xlat18 = u_xlat19 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_3.xyz * u_xlat6.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.w = u_xlat18 * _FadeAlpha;
    SV_Target0 = u_xlat1;
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
out highp vec4 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat16;
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
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat5.xyz = in_TANGENT0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yzx;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.yxz * u_xlat1.xxx;
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat5.yxz * u_xlat1.zxy;
    u_xlat2.xyz = u_xlat1.yzx * u_xlat5.xzy + (-u_xlat2.xyz);
    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.yxz;
    u_xlat3.y = u_xlat2.x;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0 = inversesqrt(u_xlat0);
    u_xlat4.xyz = vec3(u_xlat0) * u_xlat4.xyz;
    u_xlat3.x = u_xlat5.y;
    u_xlat3.z = u_xlat1.y;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.yyy;
    u_xlat5.y = u_xlat2.z;
    u_xlat2.x = u_xlat5.z;
    u_xlat2.z = u_xlat1.x;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xxx + u_xlat3.xyz;
    u_xlat5.z = u_xlat1.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD4.xyz = u_xlat5.xyz * u_xlat4.zzz + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat4.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5.w = 0.0;
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
uniform 	vec4 _CloudColor;
uniform 	vec4 _CloudTex_ST;
uniform 	float _CloudSpeed;
uniform 	vec2 _CloudTexUV2Coord;
uniform 	float _GradientRange;
uniform 	float _GradientOffset;
uniform 	float _CloudOffset;
uniform 	float _CloudMultiplyer;
uniform 	vec4 _Cloud02Color;
uniform 	vec4 _Cloud02Tex_ST;
uniform 	float _Cloud02Speed;
uniform 	vec2 _CloudTex02UV2Coord;
uniform 	float _Cloud02Offset;
uniform 	float _Cloud02Multipler;
uniform 	vec4 _ColorPalette_ST;
uniform 	float _ColorPalletteSpeed;
uniform 	mediump float _Desaturate;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseSpeed;
uniform 	vec2 _NoiseTexUV2Coord;
uniform 	float _NoiseOffset;
uniform 	float _NoiseBrightness;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarUVSpeed;
uniform 	float _StarDepth;
uniform 	vec2 _StarTexUV2Coord;
uniform 	float _StarBrightness;
uniform 	float _Power;
uniform 	float _Scale;
uniform 	float _HorizonFade;
uniform 	float _HorizonHeight;
uniform 	float _FadeAlpha;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _Cloud02Tex;
uniform lowp sampler2D _ColorPalette;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _StarTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
vec2 u_xlat16;
float u_xlat18;
float u_xlat19;
mediump float u_xlat16_19;
lowp float u_xlat10_19;
mediump float u_xlat16_21;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat12 = _Time.y * _CloudSpeed;
    u_xlat18 = vs_TEXCOORD0.y * _GradientRange + _GradientOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.x = _GradientRange + _GradientOffset;
    u_xlat1.x = (-vs_TEXCOORD0.y) * _GradientRange + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat7.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = u_xlat1.x * u_xlat7.x + u_xlat18;
    u_xlat0.xy = _Time.yy * vec2(_CloudSpeed) + u_xlat0.xy;
    u_xlat10_0 = texture(_CloudTex, u_xlat0.xy).x;
    u_xlat6.xy = vs_TEXCOORD1.xy * vec2(_CloudTexUV2Coord.x, _CloudTexUV2Coord.y) + vec2(u_xlat12);
    u_xlat10_6 = texture(_CloudTex, u_xlat6.xy).x;
    u_xlat16_6 = (-u_xlat10_0) + u_xlat10_6;
    u_xlat0.x = u_xlat18 * u_xlat16_6 + u_xlat10_0;
    u_xlat6.x = u_xlat0.x + _CloudOffset;
    u_xlat6.x = u_xlat6.x * _CloudMultiplyer;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _Cloud02Tex_ST.xy + _Cloud02Tex_ST.zw;
    u_xlat12 = _Time.y * _Cloud02Speed;
    u_xlat1.xy = _Time.yy * vec2(_Cloud02Speed) + u_xlat1.xy;
    u_xlat10_1 = texture(_Cloud02Tex, u_xlat1.xy).x;
    u_xlat7.xy = vs_TEXCOORD1.xy * vec2(_CloudTex02UV2Coord.x, _CloudTex02UV2Coord.y) + vec2(u_xlat12);
    u_xlat10_12 = texture(_Cloud02Tex, u_xlat7.xy).x;
    u_xlat16_12 = (-u_xlat10_1) + u_xlat10_12;
    u_xlat12 = u_xlat18 * u_xlat16_12 + u_xlat10_1;
    u_xlat1.x = u_xlat12 + _Cloud02Offset;
    u_xlat1.x = u_xlat1.x * _Cloud02Multipler;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat2.yz = vs_TEXCOORD0.xy * _ColorPalette_ST.xy + _ColorPalette_ST.zw;
    u_xlat2.x = _Time.y * _ColorPalletteSpeed + u_xlat2.y;
    u_xlat10_7.xyz = texture(_ColorPalette, u_xlat2.xz).xyz;
    u_xlat16_2.xyz = (-u_xlat10_7.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = vec3(u_xlat18) * u_xlat16_2.xyz + u_xlat10_7.xyz;
    u_xlat2.x = dot(u_xlat7.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = (-u_xlat7.xyz) + u_xlat2.xxx;
    u_xlat16_3.xyz = vec3(_Desaturate) * u_xlat16_3.xyz + u_xlat7.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = _Time.y * _NoiseSpeed + u_xlat2.y;
    u_xlat4.xy = vec2(vs_TEXCOORD1.x * _NoiseTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_NoiseTexUV2Coord.y));
    u_xlat4.z = _Time.y * _NoiseSpeed + u_xlat4.y;
    u_xlat10_7.x = texture(_NoiseTex, u_xlat2.xz).x;
    u_xlat10_13 = texture(_NoiseTex, u_xlat4.xz).x;
    u_xlat16_13 = (-u_xlat10_7.x) + u_xlat10_13;
    u_xlat7.x = u_xlat18 * u_xlat16_13 + u_xlat10_7.x;
    u_xlat7.x = u_xlat7.x + _NoiseOffset;
    u_xlat7.x = u_xlat7.x * _NoiseBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat6.xxx * _CloudColor.xyz;
    u_xlat1.xzw = u_xlat1.xxx * _Cloud02Color.xyz;
    u_xlat1.xzw = u_xlat1.xzw * u_xlat16_3.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat1.xzw + u_xlat2.xyz;
    u_xlat2.yw = vs_TEXCOORD0.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat4.x = _Time.y * _StarUVSpeed + u_xlat2.y;
    u_xlat4.y = float(0.0);
    u_xlat16.x = float(1.0);
    u_xlat6.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat5.xy = u_xlat6.xx * vs_TEXCOORD4.xy;
    u_xlat6.x = _StarDepth + -1.0;
    u_xlat5.xy = u_xlat5.xy * u_xlat6.xx;
    u_xlat2.xz = u_xlat5.yx * vec2(-0.100000001, -0.100000001);
    u_xlat4.xy = vec2(u_xlat2.z + u_xlat4.x, u_xlat2.w + u_xlat4.y);
    u_xlat16.y = u_xlat2.x;
    u_xlat4.xy = u_xlat4.xy + u_xlat16.xy;
    u_xlat2.xy = vec2(vs_TEXCOORD1.x * _StarTexUV2Coord.xxyx.y, vs_TEXCOORD1.y * float(_StarTexUV2Coord.y));
    u_xlat16_21 = _StarUVSpeed + -0.00999999978;
    u_xlat5.x = _Time.y * u_xlat16_21 + u_xlat2.x;
    u_xlat5.y = 0.0;
    u_xlat2.xy = vec2(u_xlat2.z + u_xlat5.x, u_xlat2.y + u_xlat5.y);
    u_xlat2.xy = u_xlat2.xy + u_xlat16.xy;
    u_xlat10_6 = texture(_StarTex, u_xlat4.xy).x;
    u_xlat10_19 = texture(_StarTex, u_xlat2.xy).x;
    u_xlat16_19 = (-u_xlat10_6) + u_xlat10_19;
    u_xlat6.x = u_xlat18 * u_xlat16_19 + u_xlat10_6;
    u_xlat18 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * vs_TEXCOORD5.xyz;
    u_xlat18 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xyz = vec3(u_xlat18) * vs_TEXCOORD6.xyz;
    u_xlat18 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat19 = vs_TEXCOORD0.y * _HorizonFade + _HorizonHeight;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Power;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = u_xlat18 * _Scale;
    u_xlat18 = u_xlat19 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat16_3.xyz * u_xlat6.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(vec3(_StarBrightness, _StarBrightness, _StarBrightness));
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.w = u_xlat18 * _FadeAlpha;
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
}
CustomEditor "MiHoYoASEMaterialInspector"
}