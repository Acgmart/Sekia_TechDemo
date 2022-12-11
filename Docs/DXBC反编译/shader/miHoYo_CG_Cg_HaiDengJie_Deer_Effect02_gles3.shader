//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/CG/Cg_HaiDengJie_Deer_Effect02" {
Properties {
_DarkColor ("DarkColor", Color) = (0.4353373,0.8970588,0.5340501,0)
_DarkColorScale ("DarkColorScale", Float) = 1
_LightColor ("LightColor", Color) = (0.1559255,0.3591666,0.7573529,0)
_LightColorScale ("LightColorScale", Float) = 1
_ColorLerp ("ColorLerp", Float) = 1
_ColorLerpScale ("ColorLerpScale", Float) = 1
_Noise ("Noise", 2D) = "white" { }
_NoiseIntensity ("NoiseIntensity", Range(0, 1)) = 0
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Mask01 ("Mask01", 2D) = "black" { }
_Mask01_Offset ("Mask01_Offset", Range(0, 1)) = 0
_AlphaMaskPower ("AlphaMaskPower", Float) = 1
_StepMin ("StepMin", Range(0, 1)) = 0.07581266
_StepMax ("StepMax", Range(0, 1)) = 0.2705882
_EdgeColor ("EdgeColor", Color) = (1,1,1,0)
_Opacity ("Opacity", Float) = 1
_FilamentLine ("FilamentLine", 2D) = "black" { }
_LineColor ("LineColor", Color) = (1,1,1,0)
_LineBirghtness ("LineBirghtness", Float) = 1
_FilamentNoise ("FilamentNoise", 2D) = "white" { }
_FilamentLineNoise ("FilamentLineNoise", Range(0, 1)) = 0
_FilamentNoise_Uspeed ("FilamentNoise_Uspeed", Float) = 0
_FilamentNoise_Vspeed ("FilamentNoise_Vspeed", Float) = 0
_Line_R_Uspeed ("Line_R_Uspeed", Float) = 0
_Line_R_Vspeed ("Line_R_Vspeed", Float) = 0
_Line_G_Uspeed ("Line_G_Uspeed", Float) = 0
_Line_G_Vspeed ("Line_G_Vspeed", Float) = 0
_RangeScale ("RangeScale", Float) = 1
_RangePower ("RangePower", Float) = 1
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
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
  GpuProgramID 5084
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_3 = u_xlat16_1.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_3 = u_xlat16_1.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat8 * u_xlat13.x + u_xlat3.x;
    u_xlat3.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat8 * u_xlat13.x + u_xlat3.x;
    u_xlat3.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat10;
lowp vec2 u_xlat10_10;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.x;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat10;
lowp vec2 u_xlat10_10;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.x;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat10;
lowp vec2 u_xlat10_10;
float u_xlat13;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8;
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_1.x = u_xlat16_2.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat3.x * u_xlat16_1.x;
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat10;
lowp vec2 u_xlat10_10;
float u_xlat13;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8;
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_1.x = u_xlat16_2.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat3.x * u_xlat16_1.x;
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

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_3 = u_xlat16_1.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3;
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

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_3 = u_xlat16_1.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat8 * u_xlat13.x + u_xlat3.x;
    u_xlat3.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x;
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

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
float u_xlat8;
mediump vec3 u_xlat16_8;
lowp float u_xlat10_8;
bool u_xlatb8;
mediump vec2 u_xlat16_12;
vec2 u_xlat13;
lowp vec2 u_xlat10_13;
mediump float u_xlat16_15;
mediump float u_xlat16_16;
void main()
{
    u_xlat16_0.x = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerp;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_1.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat13.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat13.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat13.y;
    u_xlat16_12.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat13.xy;
    u_xlat10_13.xy = texture(_FilamentNoise, u_xlat16_12.xy).xy;
    u_xlat10_4.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.xy = u_xlat10_4.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat3.x = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMin);
#else
    u_xlatb8 = u_xlat3.x>=_StepMin;
#endif
    u_xlat16_15 = (u_xlatb8) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat3.x>=_StepMax);
#else
    u_xlatb8 = u_xlat3.x>=_StepMax;
#endif
    u_xlat16_16 = (u_xlatb8) ? -1.0 : -0.0;
    u_xlat16_15 = u_xlat16_15 + u_xlat16_16;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat4.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_1.x = _Time.y * _Line_R_Uspeed + u_xlat4.y;
    u_xlat16_1.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat4.xyz;
    u_xlat16_1 = u_xlat10_13.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_1;
    u_xlat10_8 = texture(_FilamentLine, u_xlat16_1.xy).x;
    u_xlat10_13.x = texture(_FilamentLine, u_xlat16_1.zw).y;
    u_xlat16_8.x = u_xlat10_13.x + u_xlat10_8;
    u_xlat16_1.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_1.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 9.99999975e-05);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_6 = u_xlat16_1.x * _RangePower;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaMaskPower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_6 = exp2(u_xlat16_6);
    u_xlat16_6 = u_xlat16_6 * _RangeScale;
    SV_Target0.xyz = u_xlat16_8.xyz * vec3(u_xlat16_6) + u_xlat16_0.xyz;
    u_xlat16_0.x = u_xlat3.x * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_0.x * _Opacity;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat8 * u_xlat13.x + u_xlat3.x;
    u_xlat3.x = u_xlat16_0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat10;
lowp vec2 u_xlat10_10;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.x;
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

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat10;
lowp vec2 u_xlat10_10;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat10;
lowp vec2 u_xlat10_10;
float u_xlat13;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8;
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_1.x = u_xlat16_2.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat3.x * u_xlat16_1.x;
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD4;
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
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat0.zw;
    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DarkColor;
uniform 	mediump float _DarkColorScale;
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _LightColorScale;
uniform 	mediump float _ColorLerp;
uniform 	mediump float _ColorLerpScale;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump vec4 _LineColor;
uniform 	mediump float _LineBirghtness;
uniform 	mediump float _FilamentNoise_Uspeed;
uniform 	mediump float _FilamentNoise_Vspeed;
uniform 	mediump float _FilamentLineNoise;
uniform 	mediump float _Line_R_Uspeed;
uniform 	vec4 _FilamentLine_ST;
uniform 	mediump float _Line_R_Vspeed;
uniform 	mediump float _Line_G_Uspeed;
uniform 	mediump float _Line_G_Vspeed;
uniform 	mediump float _RangePower;
uniform 	mediump float _RangeScale;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform lowp sampler2D _FilamentNoise;
uniform lowp sampler2D _FilamentLine;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec2 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
mediump float u_xlat16_7;
float u_xlat8;
float u_xlat10;
lowp vec2 u_xlat10_10;
float u_xlat13;
bool u_xlatb15;
mediump float u_xlat16_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _DarkColor.xyz * vec3(_DarkColorScale);
    u_xlat16_16 = max(vs_TEXCOORD1.x, 9.99999975e-05);
    u_xlat16_16 = log2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerp;
    u_xlat16_16 = exp2(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * _ColorLerpScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _LightColor.xyz * vec3(_LightColorScale) + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_2.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_2.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_10.xy = texture(_Noise, u_xlat16_2.xy).xy;
    u_xlat16_2.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_2.y = 0.0;
    u_xlat3.xy = u_xlat16_2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xy = u_xlat10_10.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat3.xy;
    u_xlat10 = texture(_Mask01, u_xlat16_2.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMin);
#else
    u_xlatb15 = u_xlat10>=_StepMin;
#endif
    u_xlat16_16 = (u_xlatb15) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat10>=_StepMax);
#else
    u_xlatb15 = u_xlat10>=_StepMax;
#endif
    u_xlat16_2.x = (u_xlatb15) ? -1.0 : -0.0;
    u_xlat16_16 = u_xlat16_16 + u_xlat16_2.x;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _EdgeColor.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xy = _Time.yy * vec2(_FilamentNoise_Uspeed, _FilamentNoise_Vspeed) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_FilamentNoise, u_xlat16_2.xy).xy;
    u_xlat3.xyz = vs_TEXCOORD0.yxy * _FilamentLine_ST.yxy + _FilamentLine_ST.wzw;
    u_xlat16_2.x = _Time.y * _Line_R_Uspeed + u_xlat3.y;
    u_xlat16_2.yzw = _Time.yyy * vec3(_Line_R_Vspeed, _Line_G_Uspeed, _Line_G_Vspeed) + u_xlat3.xyz;
    u_xlat16_4.xyz = _LineColor.xyz * vec3(_LineBirghtness);
    u_xlat16_2 = u_xlat10_0.xyxy * vec4(vec4(_FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise, _FilamentLineNoise)) + u_xlat16_2;
    u_xlat10_0.x = texture(_FilamentLine, u_xlat16_2.xy).x;
    u_xlat10_5 = texture(_FilamentLine, u_xlat16_2.zw).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_0.xyw = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_2.x = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, 9.99999975e-05);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_7 = u_xlat16_2.x * _RangePower;
    u_xlat16_7 = exp2(u_xlat16_7);
    u_xlat16_7 = u_xlat16_7 * _RangeScale;
    u_xlat16_2.x = u_xlat16_2.x * _AlphaMaskPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat3.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD4.w);
    u_xlat8 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat8) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat13 + u_xlat8;
    SV_Target0.xyz = u_xlat16_0.xyw * vec3(u_xlat16_7) + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat10 * u_xlat16_2.x + u_xlat16_16;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_1.x = u_xlat16_2.x * u_xlat16_1.x;
    u_xlat0.x = u_xlat3.x * u_xlat16_1.x;
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
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 117959
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
  GpuProgramID 147792
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat2.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
ivec2 u_xlati2;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_1.xy).xy;
    u_xlat16_1.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_1.y = 0.0;
    u_xlat6.xy = u_xlat16_1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat6.xy;
    u_xlat0.x = texture(_Mask01, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMin);
#else
    u_xlatb3 = u_xlat0.x>=_StepMin;
#endif
    u_xlat16_1.x = (u_xlatb3) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMax);
#else
    u_xlatb3 = u_xlat0.x>=_StepMax;
#endif
    u_xlat16_4 = (u_xlatb3) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_4 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-05);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _AlphaMaskPower;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_1.x = u_xlat0.x * u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_0 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0 + (-_MotionVectorsAlphaCutoff);
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

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat2.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
ivec2 u_xlati2;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_1.xy).xy;
    u_xlat16_1.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_1.y = 0.0;
    u_xlat6.xy = u_xlat16_1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat6.xy;
    u_xlat0.x = texture(_Mask01, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMin);
#else
    u_xlatb3 = u_xlat0.x>=_StepMin;
#endif
    u_xlat16_1.x = (u_xlatb3) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMax);
#else
    u_xlatb3 = u_xlat0.x>=_StepMax;
#endif
    u_xlat16_4 = (u_xlatb3) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_4 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-05);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _AlphaMaskPower;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_1.x = u_xlat0.x * u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_0 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_0 + (-_MotionVectorsAlphaCutoff);
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
Keywords { "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat2.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_1.xy).xy;
    u_xlat16_1.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_1.y = 0.0;
    u_xlat6.xy = u_xlat16_1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat6.xy;
    u_xlat0.x = texture(_Mask01, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMin);
#else
    u_xlatb3 = u_xlat0.x>=_StepMin;
#endif
    u_xlat16_1.x = (u_xlatb3) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMax);
#else
    u_xlatb3 = u_xlat0.x>=_StepMax;
#endif
    u_xlat16_4 = (u_xlatb3) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_4 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-05);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _AlphaMaskPower;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_1.x = u_xlat0.x * u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_1.x = u_xlat16_4 * u_xlat16_1.x;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3 * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec4 _ProjectionParams;
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
out highp vec4 vs_TEXCOORD5;
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
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat2.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _StepMin;
uniform 	mediump float _Noise_Uspeed;
uniform 	vec4 _Noise_ST;
uniform 	mediump float _Noise_Vspeed;
uniform 	mediump float _NoiseIntensity;
uniform 	mediump float _Mask01_Offset;
uniform 	mediump float _StepMax;
uniform 	mediump float _AlphaMaskPower;
uniform 	mediump float _Opacity;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask01;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
ivec2 u_xlati2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _Noise_ST.xy + _Noise_ST.zw;
    u_xlat16_1.x = _Time.y * _Noise_Uspeed + u_xlat0.x;
    u_xlat16_1.y = _Time.y * _Noise_Vspeed + u_xlat0.y;
    u_xlat10_0.xy = texture(_Noise, u_xlat16_1.xy).xy;
    u_xlat16_1.x = _Mask01_Offset * -0.949999988 + 0.899999976;
    u_xlat16_1.y = 0.0;
    u_xlat6.xy = u_xlat16_1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(vec2(_NoiseIntensity, _NoiseIntensity)) + u_xlat6.xy;
    u_xlat0.x = texture(_Mask01, u_xlat16_1.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMin);
#else
    u_xlatb3 = u_xlat0.x>=_StepMin;
#endif
    u_xlat16_1.x = (u_xlatb3) ? 1.0 : 0.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=_StepMax);
#else
    u_xlatb3 = u_xlat0.x>=_StepMax;
#endif
    u_xlat16_4 = (u_xlatb3) ? -1.0 : -0.0;
    u_xlat16_1.x = u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_4 = (-vs_TEXCOORD0.x) + 1.0;
    u_xlat16_4 = max(u_xlat16_4, 9.99999975e-05);
    u_xlat16_4 = log2(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * _AlphaMaskPower;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_1.x = u_xlat0.x * u_xlat16_4 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _Opacity;
    u_xlat16_1.x = u_xlat16_4 * u_xlat16_1.x;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3 * u_xlat6.x + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
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
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}