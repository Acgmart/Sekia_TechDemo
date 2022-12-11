//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_HaiDengJie_Deer_Antler" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,0)
_GlobalAlpha ("GlobalAlpha", Range(0, 20)) = 0
_MainTex ("MainTex", 2D) = "black" { }
_Main_R_Uspeed ("Main_R_Uspeed", Range(-1, 1)) = 0
_Main_R_Vspeed ("Main_R_Vspeed", Range(-1, 1)) = 0
_Main_G_Uspeed ("Main_G_Uspeed", Range(-1, 1)) = 0
_Main_G_Vspeed ("Main_G_Vspeed", Range(-1, 1)) = 0
_MainTexNoise ("MainTexNoise", Range(0, 1)) = 0
_MainTexRangePower ("MainTexRangePower", Range(0, 10)) = 1
_MainTexRangeScale ("MainTexRangeScale", Range(0, 10)) = 1
_LightColor ("LightColor", Color) = (1,1,1,0)
_DarkColor ("DarkColor", Color) = (1,1,1,0)
_Mask ("Mask", 2D) = "black" { }
_ColorRangePower ("ColorRangePower", Range(0, 5)) = 1
_ColorRangeScale ("ColorRangeScale", Range(0, 10)) = 1
_MaskNoise ("MaskNoise", Range(0, 1)) = 0
_Noise ("Noise", 2D) = "white" { }
_Noise_Uspeed ("Noise_Uspeed", Range(-1, 1)) = 0
_Noise_Vspeed ("Noise_Vspeed", Range(-1, 1)) = 0
_NoiseOffset_U ("NoiseOffset_U", Range(-1, 1)) = 0
_NoiseOffset_V ("NoiseOffset_V", Range(-1, 1)) = 0
_TopEdgeColor ("TopEdgeColor", Color) = (1,1,1,0)
_TopEdgePower ("TopEdgePower", Range(0, 10)) = 1
_TopEdgeScale ("TopEdgeScale", Range(0, 50)) = 5
_DissolveEdgeColor ("DissolveEdgeColor", Color) = (1,1,1,0)
_DissolveEdgeMin ("DissolveEdgeMin", Range(0, 1)) = 0.07581266
_DissolveEdgeMax ("DissolveEdgeMax", Range(0, 1)) = 0.2705882
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
  GpuProgramID 50495
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_1.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_1 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_1;
    u_xlat10_8 = texture(_MainTex, u_xlat16_1.xy).x;
    u_xlat10_12 = texture(_MainTex, u_xlat16_1.zw).y;
    u_xlat16_8 = u_xlat10_12 + u_xlat10_8;
    u_xlat16_1.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.x * _ColorRangePower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat16_5.xyz = _MainColor.xyz * vec3(u_xlat16_8) + u_xlat16_5.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_8) * _MainColor.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat8.xy;
    u_xlat0.x = texture(_Mask, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMin);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMin;
#endif
    u_xlat16_2.x = (u_xlatb4) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMax);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMax;
#endif
    u_xlat16_6 = (u_xlatb4) ? -1.0 : -0.0;
    u_xlat16_2.x = u_xlat16_6 + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_5.xyz = _DissolveEdgeColor.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_1.x * _MainTexRangePower;
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _MainTexRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _TopEdgeColor.xyz;
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_1.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_1 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_1;
    u_xlat10_8 = texture(_MainTex, u_xlat16_1.xy).x;
    u_xlat10_12 = texture(_MainTex, u_xlat16_1.zw).y;
    u_xlat16_8 = u_xlat10_12 + u_xlat10_8;
    u_xlat16_1.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.x * _ColorRangePower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat16_5.xyz = _MainColor.xyz * vec3(u_xlat16_8) + u_xlat16_5.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_8) * _MainColor.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat8.xy;
    u_xlat0.x = texture(_Mask, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMin);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMin;
#endif
    u_xlat16_2.x = (u_xlatb4) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMax);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMax;
#endif
    u_xlat16_6 = (u_xlatb4) ? -1.0 : -0.0;
    u_xlat16_2.x = u_xlat16_6 + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_5.xyz = _DissolveEdgeColor.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_1.x * _MainTexRangePower;
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _MainTexRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _TopEdgeColor.xyz;
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_13;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat12.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat12.xy;
    u_xlat12.x = texture(_Mask, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMin);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMin;
#endif
    u_xlat16_1.x = (u_xlatb18) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMax);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMax;
#endif
    u_xlat16_7.x = (u_xlatb18) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_7.x + u_xlat16_1.x;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_7.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_13 = u_xlat16_7.x * _ColorRangePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_4.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_4.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_3 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_4;
    u_xlat10_0.x = texture(_MainTex, u_xlat16_3.xy).x;
    u_xlat10_6 = texture(_MainTex, u_xlat16_3.zw).y;
    u_xlat16_0 = u_xlat10_6 + u_xlat10_0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_0) * _MainColor.xyz;
    u_xlat16_13 = u_xlat16_7.x * _MainTexRangePower;
    u_xlat16_7.y = exp2(u_xlat16_13);
    u_xlat16_7.x = u_xlat16_7.x * _TopEdgePower;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(_TopEdgeScale, _MainTexRangeScale);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _MainColor.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _DissolveEdgeColor.xyz * u_xlat16_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_7.yyy + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz + _TopEdgeColor.xyz;
    u_xlat16_1.x = u_xlat12.x + u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_13;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat12.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat12.xy;
    u_xlat12.x = texture(_Mask, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMin);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMin;
#endif
    u_xlat16_1.x = (u_xlatb18) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMax);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMax;
#endif
    u_xlat16_7.x = (u_xlatb18) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_7.x + u_xlat16_1.x;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_7.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_13 = u_xlat16_7.x * _ColorRangePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_4.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_4.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_3 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_4;
    u_xlat10_0.x = texture(_MainTex, u_xlat16_3.xy).x;
    u_xlat10_6 = texture(_MainTex, u_xlat16_3.zw).y;
    u_xlat16_0 = u_xlat10_6 + u_xlat10_0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_0) * _MainColor.xyz;
    u_xlat16_13 = u_xlat16_7.x * _MainTexRangePower;
    u_xlat16_7.y = exp2(u_xlat16_13);
    u_xlat16_7.x = u_xlat16_7.x * _TopEdgePower;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(_TopEdgeScale, _MainTexRangeScale);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _MainColor.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _DissolveEdgeColor.xyz * u_xlat16_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_7.yyy + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz + _TopEdgeColor.xyz;
    u_xlat16_1.x = u_xlat12.x + u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_1.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_1 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_1;
    u_xlat10_8 = texture(_MainTex, u_xlat16_1.xy).x;
    u_xlat10_12 = texture(_MainTex, u_xlat16_1.zw).y;
    u_xlat16_8 = u_xlat10_12 + u_xlat10_8;
    u_xlat16_1.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.x * _ColorRangePower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat16_5.xyz = _MainColor.xyz * vec3(u_xlat16_8) + u_xlat16_5.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_8) * _MainColor.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat8.xy;
    u_xlat0.x = texture(_Mask, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMin);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMin;
#endif
    u_xlat16_2.x = (u_xlatb4) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMax);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMax;
#endif
    u_xlat16_6 = (u_xlatb4) ? -1.0 : -0.0;
    u_xlat16_2.x = u_xlat16_6 + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_5.xyz = _DissolveEdgeColor.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_1.x * _MainTexRangePower;
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _MainTexRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _TopEdgeColor.xyz;
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump float u_xlat16_8;
lowp float u_xlat10_8;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_1.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_1 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_1;
    u_xlat10_8 = texture(_MainTex, u_xlat16_1.xy).x;
    u_xlat10_12 = texture(_MainTex, u_xlat16_1.zw).y;
    u_xlat16_8 = u_xlat10_12 + u_xlat10_8;
    u_xlat16_1.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.x * _ColorRangePower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat16_5.xyz = _MainColor.xyz * vec3(u_xlat16_8) + u_xlat16_5.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_8) * _MainColor.xyz;
    u_xlat8.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_2.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat8.xy;
    u_xlat0.x = texture(_Mask, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMin);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMin;
#endif
    u_xlat16_2.x = (u_xlatb4) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=_DissolveEdgeMax);
#else
    u_xlatb4 = u_xlat0.x>=_DissolveEdgeMax;
#endif
    u_xlat16_6 = (u_xlatb4) ? -1.0 : -0.0;
    u_xlat16_2.x = u_xlat16_6 + u_xlat16_2.x;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_5.xyz = _DissolveEdgeColor.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_2.x = u_xlat0.x + u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_1.x * _MainTexRangePower;
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _TopEdgeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _MainTexRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_3.xyz * u_xlat16_2.xxx + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + _TopEdgeColor.xyz;
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_13;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat12.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat12.xy;
    u_xlat12.x = texture(_Mask, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMin);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMin;
#endif
    u_xlat16_1.x = (u_xlatb18) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMax);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMax;
#endif
    u_xlat16_7.x = (u_xlatb18) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_7.x + u_xlat16_1.x;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_7.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_13 = u_xlat16_7.x * _ColorRangePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_4.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_4.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_3 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_4;
    u_xlat10_0.x = texture(_MainTex, u_xlat16_3.xy).x;
    u_xlat10_6 = texture(_MainTex, u_xlat16_3.zw).y;
    u_xlat16_0 = u_xlat10_6 + u_xlat10_0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_0) * _MainColor.xyz;
    u_xlat16_13 = u_xlat16_7.x * _MainTexRangePower;
    u_xlat16_7.y = exp2(u_xlat16_13);
    u_xlat16_7.x = u_xlat16_7.x * _TopEdgePower;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(_TopEdgeScale, _MainTexRangeScale);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _MainColor.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _DissolveEdgeColor.xyz * u_xlat16_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_7.yyy + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz + _TopEdgeColor.xyz;
    u_xlat16_1.x = u_xlat12.x + u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	mediump vec4 _TopEdgeColor;
uniform 	mediump vec4 _DissolveEdgeColor;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMax;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _ColorRangePower;
uniform 	mediump float _ColorRangeScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _MainTexNoise;
uniform 	mediump float _Main_R_Uspeed;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Main_R_Vspeed;
uniform 	mediump float _Main_G_Uspeed;
uniform 	mediump float _Main_G_Vspeed;
uniform 	mediump float _MainTexRangePower;
uniform 	mediump float _MainTexRangeScale;
uniform 	mediump float _TopEdgePower;
uniform 	mediump float _TopEdgeScale;
uniform 	mediump float _GlobalAlpha;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
lowp float u_xlat10_6;
mediump vec2 u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_13;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat12.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat12.xy;
    u_xlat12.x = texture(_Mask, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMin);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMin;
#endif
    u_xlat16_1.x = (u_xlatb18) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat12.x>=_DissolveEdgeMax);
#else
    u_xlatb18 = u_xlat12.x>=_DissolveEdgeMax;
#endif
    u_xlat16_7.x = (u_xlatb18) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_7.x + u_xlat16_1.x;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_7.x = max(vs_TEXCOORD0.x, 9.99999975e-05);
    u_xlat16_7.x = log2(u_xlat16_7.x);
    u_xlat16_13 = u_xlat16_7.x * _ColorRangePower;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_13 * _ColorRangeScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = (-_LightColor.xyz) + _DarkColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _LightColor.xyz;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _MainTex_ST.yxy + _MainTex_ST.wzw;
    u_xlat16_4.x = _Time.y * _Main_R_Uspeed + u_xlat3.y;
    u_xlat16_4.yzw = _Time.yyy * vec3(_Main_R_Vspeed, _Main_G_Uspeed, _Main_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_3 = u_xlat10_0.xyxy * vec4(_MainTexNoise) + u_xlat16_4;
    u_xlat10_0.x = texture(_MainTex, u_xlat16_3.xy).x;
    u_xlat10_6 = texture(_MainTex, u_xlat16_3.zw).y;
    u_xlat16_0 = u_xlat10_6 + u_xlat10_0.x;
    u_xlat16_5.xyz = vec3(u_xlat16_0) * _MainColor.xyz;
    u_xlat16_13 = u_xlat16_7.x * _MainTexRangePower;
    u_xlat16_7.y = exp2(u_xlat16_13);
    u_xlat16_7.x = u_xlat16_7.x * _TopEdgePower;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(_TopEdgeScale, _MainTexRangeScale);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _MainColor.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = _DissolveEdgeColor.xyz * u_xlat16_1.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * u_xlat16_7.yyy + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_TopEdgeColor.xyz);
    SV_Target0.xyz = u_xlat16_7.xxx * u_xlat16_2.xyz + _TopEdgeColor.xyz;
    u_xlat16_1.x = u_xlat12.x + u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
  GpuProgramID 82426
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
  GpuProgramID 166032
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
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _GlobalAlpha;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _DissolveEdgeMax;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
ivec2 u_xlati3;
bvec2 u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat8.xy;
    u_xlat0.x = texture(_Mask, u_xlat16_1.xy).x;
    u_xlatb4.xy = greaterThanEqual(u_xlat0.xxxx, vec4(_DissolveEdgeMin, _DissolveEdgeMax, _DissolveEdgeMin, _DissolveEdgeMin)).xy;
    u_xlat16_1.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb4.y) ? float(-1.0) : float(-0.0);
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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
uniform 	vec4 _Time;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _GlobalAlpha;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _NoiseOffset_U;
uniform 	mediump float _NoiseOffset_V;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _MaskNoise;
uniform 	vec4 _Mask_ST;
uniform 	mediump float _DissolveEdgeMin;
uniform 	mediump float _DissolveEdgeMax;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec2 u_xlat16_2;
ivec2 u_xlati3;
bvec2 u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.xy = u_xlat0.xy + vec2(_NoiseOffset_U, _NoiseOffset_V);
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat16_1.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat16_1.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _Mask_ST.xy + _Mask_ST.zw;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_MaskNoise, _MaskNoise)) + u_xlat8.xy;
    u_xlat0.x = texture(_Mask, u_xlat16_1.xy).x;
    u_xlatb4.xy = greaterThanEqual(u_xlat0.xxxx, vec4(_DissolveEdgeMin, _DissolveEdgeMax, _DissolveEdgeMin, _DissolveEdgeMin)).xy;
    u_xlat16_1.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_1.y = (u_xlatb4.y) ? float(-1.0) : float(-0.0);
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _GlobalAlpha;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0 = u_xlat16_1.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati3.xy;
    u_xlat8.xy = vec2(u_xlati8.xy);
    u_xlat0.xy = u_xlat8.xy * u_xlat0.xy;
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