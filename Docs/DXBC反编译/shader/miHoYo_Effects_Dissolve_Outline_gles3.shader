//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/Dissolve_Outline" {
Properties {
_DayColor ("DayColor", Color) = (1,1,1,1)
[Toggle(_PARTICLESYSTEM_ON)] _ParticleSystem ("ParticleSystem", Float) = 0
_FadeTotal ("FadeTotal", Range(0, 1)) = 0
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainColorBrightness ("MainColorBrightness", Float) = 1
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskPannerXY ("MaskPanner(XY)", Vector) = (0,0,0,0)
_MaskChannelNum ("MaskChannelNum", Range(0, 4)) = 1
_MaskScale ("MaskScale", Float) = 1
_Dissolve ("Dissolve", Range(0, 1)) = 0
_OutlineColorA2Width ("OutlineColor(A2Width)", Color) = (1,1,1,1)
_OutlineColorBrightness ("OutlineColorBrightness", Float) = 1
_DistortTex ("DistortTex", 2D) = "white" { }
_DistortTexPanner ("DistortTexPanner", Vector) = (0,0,0,0)
_DistortChannelNum ("DistortChannelNum", Range(0, 4)) = 1
_DistortScale ("DistortScale", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DepthScale ("DepthScale", Float) = 1
_DepthFadeOutLine ("DepthFadeOutLine", Range(0, 1)) = 1
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
  GpuProgramID 54384
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_7;
    u_xlat16_1.xzw = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat16_4) * u_xlat16_1.xzw;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_4 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_4);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_4;
#endif
    u_xlat16_4 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_4>=0.0299999993;
#endif
    u_xlat16_4 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat16_7 = (-_Dissolve) + 1.0;
    u_xlat6 = u_xlat6 * u_xlat16_7;
    u_xlat16_7 = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_7 + u_xlat16_4;
    u_xlat0.x = u_xlat16_7 * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4.x = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4.x>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_4.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.x = u_xlat16_4.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_7 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_7 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_4.x * u_xlat16_7;
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat3.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat3.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat3.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat3.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_4 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_7 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_7);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat3.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat3.x * u_xlat6 + u_xlat0.x;
    u_xlat3.x = (-u_xlat0.x) + 1.0;
    u_xlat6 = u_xlat3.x * _DepthScale;
    u_xlat6 = u_xlat16_1.x * u_xlat6;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat6 = u_xlat6 * u_xlat16_1.x + u_xlat16_7;
    u_xlat0.x = u_xlat16_1.x * u_xlat3.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_4 + u_xlat6;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_4 = max(u_xlat3.x, 9.99999975e-05);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-_FadeTotal) + 1.0;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_4;
    u_xlat16_1.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_1.xyz = vec3(u_xlat6) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_1.xyz = u_xlat16_2.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
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
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_7 = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_7);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_7;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_7>=0.0299999993;
#endif
    u_xlat16_7 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = vec3(u_xlat16_7) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_7;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_6.x = _OutlineColorA2Width.w * _Dissolve;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=u_xlat16_6.x);
#else
    u_xlatb0.x = u_xlat16_2.x>=u_xlat16_6.x;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_6.x>=0.0299999993;
#endif
    u_xlat16_6.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_10 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_14 = (-_Dissolve) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_14;
    u_xlat12 = u_xlat12 * u_xlat16_10 + u_xlat16_6.x;
    u_xlat0.x = u_xlat16_10 * u_xlat8.x + u_xlat0.x;
    u_xlat16_6.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * vs_COLOR0.xyz;
    u_xlat16_6.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_2.x = u_xlat16_2.x + u_xlat12;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_10;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_2.x * u_xlat16_6.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xz).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_7;
vec2 u_xlat10;
mediump vec2 u_xlat16_10;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat10.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat10.xy = _Time.yy * _DistortTexPanner.xy + u_xlat10.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat10.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_10.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_10.x = u_xlat16_10.y + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_10.x;
    u_xlat16_10.x = u_xlat16_3.x + u_xlat16_10.x;
    u_xlat16_2.xy = u_xlat16_10.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_7 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat16_7>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_2.x>=0.0299999993;
#endif
    u_xlat16_2.x = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3.xyz = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_4.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_4.xyz = u_xlat16_2.xxx * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _MainColor.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_12 = (-_FadeTotal) + 1.0;
    u_xlat16_17 = max(u_xlat5, 9.99999975e-05);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_17;
    u_xlat16_2.x = u_xlat16_7 + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_17;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
out highp vec4 vs_TEXCOORD5;
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
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _DayColor;
uniform 	mediump float _MainColorBrightness;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _OutlineColorBrightness;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _FadeTotal;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
mediump float u_xlat16_10;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat0.xy = _Time.yy * vec2(_MaskPannerXY.x, _MaskPannerXY.y) + u_xlat0.xy;
    u_xlat8.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat8.xy = _Time.yy * _DistortTexPanner.xy + u_xlat8.xy;
    u_xlat10_1 = texture(_DistortTex, u_xlat8.xy);
    u_xlat16_2 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_3.xy = (-u_xlat16_3.xy) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_8.x = u_xlat16_8.y + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_8.x;
    u_xlat16_8.x = u_xlat16_3.x + u_xlat16_8.x;
    u_xlat16_2.xy = u_xlat16_8.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat0.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_2.xy);
    u_xlat16_1 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_3.y + u_xlat16_0.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_2.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_6 = u_xlat16_0.x + (-u_xlat16_2.x);
    u_xlat16_10 = u_xlat16_2.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_6>=u_xlat16_10);
#else
    u_xlatb0.x = u_xlat16_6>=u_xlat16_10;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 0.0 : 1.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10>=0.0299999993);
#else
    u_xlatb0.x = u_xlat16_10>=0.0299999993;
#endif
    u_xlat16_10 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat0.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat8.x;
    u_xlat16_14 = floor(_DepthFadeOutLine);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat12 = u_xlat8.x * _DepthScale;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat12 = u_xlat12 * u_xlat16_2.x;
    u_xlat12 = u_xlat12 * u_xlat16_14 + u_xlat16_10;
    u_xlat0.x = u_xlat16_14 * u_xlat8.x + u_xlat0.x;
    u_xlat16_2.xzw = _DayColor.xyz * vec3(_MainColorBrightness);
    u_xlat16_3.xyz = _OutlineColorA2Width.xyz * vec3(_OutlineColorBrightness);
    u_xlat16_3.xyz = vec3(u_xlat12) * u_xlat16_3.xyz;
    u_xlat16_2.xzw = u_xlat16_2.xzw * _MainColor.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xzw * vs_COLOR0.xyz;
    u_xlat16_2.x = (-_FadeTotal) + 1.0;
    u_xlat16_10 = max(u_xlat4, 9.99999975e-05);
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    u_xlat16_6 = u_xlat16_6 + u_xlat12;
    u_xlat16_6 = u_xlat16_6 * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_6 * u_xlat16_10;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_6 * u_xlat16_2.x;
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
Keywords { "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
Keywords { "FOG_HEIGHT" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 113239
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
  GpuProgramID 183983
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat16_9 = (-_Dissolve) + 1.0;
    u_xlat8.x = u_xlat8.x * u_xlat16_9;
    u_xlat16_9 = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_9 + u_xlat16_5;
    u_xlat0.x = u_xlat16_9 * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat16_9 = (-_Dissolve) + 1.0;
    u_xlat8.x = u_xlat8.x * u_xlat16_9;
    u_xlat16_9 = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_9 + u_xlat16_5;
    u_xlat0.x = u_xlat16_9 * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat16_9 = (-_Dissolve) + 1.0;
    u_xlat8.x = u_xlat8.x * u_xlat16_9;
    u_xlat16_9 = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_9 + u_xlat16_5;
    u_xlat0.x = u_xlat16_9 * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _Dissolve;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = u_xlat16_0.x + (-_Dissolve);
    u_xlat16_5 = _Dissolve * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=u_xlat16_5);
#else
    u_xlatb0 = u_xlat16_1.x>=u_xlat16_5;
#endif
    u_xlat16_5 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_5>=0.0299999993;
#endif
    u_xlat16_5 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat16_9 = (-_Dissolve) + 1.0;
    u_xlat8.x = u_xlat8.x * u_xlat16_9;
    u_xlat16_9 = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_9 + u_xlat16_5;
    u_xlat0.x = u_xlat16_9 * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "_PARTICLESYSTEM_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_9 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_9);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_9;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_9>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_9>=0.0299999993;
#endif
    u_xlat16_9 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat8.x = u_xlat16_1.x * u_xlat8.x;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_1.x + u_xlat16_9;
    u_xlat0.x = u_xlat16_1.x * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_5 + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_9 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_9);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_9;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_9>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_9>=0.0299999993;
#endif
    u_xlat16_9 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat8.x = u_xlat16_1.x * u_xlat8.x;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_1.x + u_xlat16_9;
    u_xlat0.x = u_xlat16_1.x * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_5 + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_9 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_9);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_9;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_9>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_9>=0.0299999993;
#endif
    u_xlat16_9 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat8.x = u_xlat16_1.x * u_xlat8.x;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_1.x + u_xlat16_9;
    u_xlat0.x = u_xlat16_1.x * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_5 + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
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
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _OutlineColorA2Width.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_1.x;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1.x>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_1.x>=0.0299999993;
#endif
    u_xlat16_1.x = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat16_1.x = u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat0.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	mediump float _FadeTotal;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec2 _MaskPannerXY;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump vec2 _DistortTexPanner;
uniform 	vec4 _DistortTex_ST;
uniform 	mediump float _DistortChannelNum;
uniform 	mediump float _DistortScale;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump vec4 _OutlineColorA2Width;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _DepthScale;
uniform 	mediump float _DepthFadeOutLine;
uniform 	mediump float _MaskScale;
uniform lowp sampler2D _DistortTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec2 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
ivec2 u_xlati3;
vec2 u_xlat4;
mediump float u_xlat16_5;
vec2 u_xlat8;
ivec2 u_xlati8;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortTex_ST.xy + _DistortTex_ST.zw;
    u_xlat0.xy = _Time.yy * _DistortTexPanner.xy + u_xlat0.xy;
    u_xlat10_0 = texture(_DistortTex, u_xlat0.xy);
    u_xlat16_1 = (-vec4(_DistortChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_1 = min(abs(u_xlat16_1), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_1 = (-u_xlat16_1) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_1.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_1.w + u_xlat16_0.x;
    u_xlat16_1.xy = min(abs(vec2(_DistortChannelNum, _MaskChannelNum)), vec2(1.0, 1.0));
    u_xlat16_1.xy = (-u_xlat16_1.xy) + vec2(1.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat4.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat4.xy = _Time.yy * _MaskPannerXY.xy + u_xlat4.xy;
    u_xlat16_1.xz = u_xlat16_0.xx * vec2(vec2(_DistortScale, _DistortScale)) + u_xlat4.xy;
    u_xlat10_0 = texture(_MaskTex, u_xlat16_1.xz);
    u_xlat16_2 = (-vec4(vec4(_MaskChannelNum, _MaskChannelNum, _MaskChannelNum, _MaskChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0.xy = u_xlat10_0.xy * u_xlat16_2.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.z * u_xlat16_2.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1.y + u_xlat16_0.x;
    u_xlat16_1.x = (-_MainColor.w) * vs_COLOR0.w + 1.0;
    u_xlat16_5 = u_xlat16_0.x + (-u_xlat16_1.x);
    u_xlat16_9 = u_xlat16_1.x * _OutlineColorA2Width.w;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_5>=u_xlat16_9);
#else
    u_xlatb0 = u_xlat16_5>=u_xlat16_9;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_9>=0.0299999993);
#else
    u_xlatb0 = u_xlat16_9>=0.0299999993;
#endif
    u_xlat16_9 = (u_xlatb0) ? 1.0 : 0.0;
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4.x = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat8.x + u_xlat0.x;
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat8.x = u_xlat4.x * _DepthScale;
    u_xlat8.x = u_xlat16_1.x * u_xlat8.x;
    u_xlat16_1.x = floor(_DepthFadeOutLine);
    u_xlat8.x = u_xlat8.x * u_xlat16_1.x + u_xlat16_9;
    u_xlat0.x = u_xlat16_1.x * u_xlat4.x + u_xlat0.x;
    u_xlat16_1.x = u_xlat16_5 + u_xlat8.x;
    u_xlat16_1.x = u_xlat16_1.x * _MaskScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_5 = max(u_xlat4.x, 9.99999975e-05);
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-_FadeTotal) + 1.0;
    u_xlat16_1.x = u_xlat16_5 * u_xlat16_1.x + (-_MotionVectorsAlphaCutoff);
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
Keywords { "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_PARTICLESYSTEM_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_PARTICLESYSTEM_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}