//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Fire_Commom" {
Properties {
_ColorInner ("ColorInner", Color) = (1,0.753779,0.2132353,0)
_ColorOutter ("ColorOutter", Color) = (0.8970588,0.2483743,0.07915227,0)
[MHYToggle] _LerpAddAlphaToggle ("LerpAddAlphaToggle", Float) = 0
_ShapeTex ("ShapeTex", 2D) = "white" { }
_ShapeBlueBrightness ("ShapeBlueBrightness", Float) = 0.8
_VcoordMultiplier ("VcoordMultiplier", Float) = 1
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _Noise01ChannelSwitch ("Noise01ChannelSwitch", Float) = 0
_Noise01_Uspeed ("Noise01_Uspeed", Float) = 0
_Noise01_Vspeed ("Noise01_Vspeed", Float) = -0.9
_NoiseTex01Brightness ("NoiseTex01Brightness", Range(0, 3)) = 1.22
_NoiseTex01Offset ("NoiseTex01Offset", Range(0, 2)) = 0
[MHYToggle] _Noise01_RandomToggle ("Noise01_RandomToggle", Float) = 0
[Toggle(_2NDNOISETEXTOGGLE_ON)] _2ndNoiseTexToggle ("2ndNoiseTexToggle", Float) = 0
_2ndNoiseTex ("2ndNoiseTex", 2D) = "black" { }
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
[Enum(R,0,G,1,B,2,A,3)] _2ndNoiseChannelSwitch ("2ndNoiseChannelSwitch", Float) = 0
_Noise02_Uspeed ("Noise02_Uspeed", Float) = 1
_Noise02_Vspeed ("Noise02_Vspeed", Float) = 1
_2ndNoiseTexBrightness ("2ndNoiseTexBrightness", Range(0, 3)) = 1
_2ndNoiseTexOffset ("2ndNoiseTexOffset", Range(0, 2)) = 0.46
[MHYToggle] _2ndNoise_RandomToggle ("2ndNoise_RandomToggle", Float) = 0
[MHYToggle] _NoiseAsVcoordToggle ("NoiseAsVcoordToggle", Float) = 1
_AlphaEdgeFade ("AlphaEdgeFade", Float) = 1
_TimeScale ("TimeScale", Float) = 1
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_GrassFireBurnOut ("GrassFireBurnOut", Float) = 0
_DayColor ("DayColor", Color) = (1,1,1,1)
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
  GpuProgramID 17868
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTexture, u_xlat8.xy).x;
    u_xlat8.x = _ZBufferParams.z * u_xlat8.x + _ZBufferParams.w;
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb4 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_8 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat8.x = u_xlat10_8 * _ShapeBlueBrightness;
    u_xlat4.x = u_xlat4.x * u_xlat8.x;
    u_xlat8.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb12 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb12) ? u_xlat4.x : u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_4.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat1.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat8.x = u_xlat10_4.y * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat10_4.z * u_xlat10_4.z + u_xlat10_4.x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati12]._MeshParticleColorArray.w + 1.0;
    u_xlat1.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat8.x = u_xlat8.x + (-u_xlat1.x);
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati12]._MeshParticleColorArray.xy;
    u_xlat12 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati12]._MeshParticleColorArray.w + u_xlat4.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat8.x = u_xlat8.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb0 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTextureScaled, u_xlat8.xy).x;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat9;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTextureScaled, u_xlat1.xz).x;
    u_xlat12 = u_xlat12 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.x = u_xlat12 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat12 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat9 + u_xlat12;
    u_xlat2.w = u_xlat12 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTexture, u_xlat8.xy).x;
    u_xlat8.x = _ZBufferParams.z * u_xlat8.x + _ZBufferParams.w;
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat9;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTexture, u_xlat1.xz).x;
    u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 + (-vs_TEXCOORD5.w);
    u_xlat1.x = u_xlat12 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat12 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat9 + u_xlat12;
    u_xlat2.w = u_xlat12 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTextureScaled, u_xlat8.xy).x;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat9;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTextureScaled, u_xlat1.xz).x;
    u_xlat12 = u_xlat12 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.x = u_xlat12 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat12 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat9 + u_xlat12;
    u_xlat2.w = u_xlat12 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTexture, u_xlat8.xy).x;
    u_xlat8.x = _ZBufferParams.z * u_xlat8.x + _ZBufferParams.w;
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
lowp float u_xlat10_8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
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
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb4 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_8 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat8.x = u_xlat10_8 * _ShapeBlueBrightness;
    u_xlat4.x = u_xlat4.x * u_xlat8.x;
    u_xlat8.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb12 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb12) ? u_xlat4.x : u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_4.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat1.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat8.x = u_xlat10_4.y * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat10_4.z * u_xlat10_4.z + u_xlat10_4.x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati12]._MeshParticleColorArray.w + 1.0;
    u_xlat1.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat8.x = u_xlat8.x + (-u_xlat1.x);
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati12]._MeshParticleColorArray.xy;
    u_xlat12 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati12]._MeshParticleColorArray.w + u_xlat4.x;
    u_xlat8.x = u_xlat8.x * u_xlat1.x;
    u_xlat8.x = u_xlat8.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat2.w = u_xlat0.x * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb0 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTextureScaled, u_xlat8.xy).x;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat9;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTextureScaled, u_xlat1.xz).x;
    u_xlat12 = u_xlat12 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.x = u_xlat12 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat12 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat9 + u_xlat12;
    u_xlat2.w = u_xlat12 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTexture, u_xlat8.xy).x;
    u_xlat8.x = _ZBufferParams.z * u_xlat8.x + _ZBufferParams.w;
    u_xlat8.x = float(1.0) / u_xlat8.x;
    u_xlat8.x = u_xlat8.x + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat9;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTexture, u_xlat1.xz).x;
    u_xlat12 = _ZBufferParams.z * u_xlat12 + _ZBufferParams.w;
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = u_xlat12 + (-vs_TEXCOORD5.w);
    u_xlat1.x = u_xlat12 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat12 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat9 + u_xlat12;
    u_xlat2.w = u_xlat12 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat1.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat8.x) + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat8.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat8.x = texture(_CameraDepthTextureScaled, u_xlat8.xy).x;
    u_xlat8.x = u_xlat8.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat12 = u_xlat8.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat8.x) + 1.0;
    u_xlat8.x = u_xlat12 * u_xlat1.x + u_xlat8.x;
    u_xlat1.w = u_xlat8.x * u_xlat4.x;
    u_xlat4.x = u_xlat0.x + vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb8 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb8) ? u_xlat4.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat2.w = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
bool u_xlatb8;
float u_xlat9;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat12 = u_xlat1.z * _AlphaEdgeFade;
    u_xlat4.x = u_xlat12 * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.z * u_xlat10_0.z + u_xlat10_0.x;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + 1.0;
    u_xlat12 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.xy;
    u_xlat8.x = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati8]._MeshParticleColorArray.w + u_xlat0.x;
    u_xlat4.x = u_xlat4.x * u_xlat1.x;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xz = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTextureScaled, u_xlat1.xz).x;
    u_xlat12 = u_xlat12 * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat1.x = u_xlat12 / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12 = u_xlat12 * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat9 + u_xlat12;
    u_xlat2.w = u_xlat12 * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb4 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _ColorInner.xyz;
    u_xlat0.xyz = u_xlat1.yyy * u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec3 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
float u_xlat8;
float u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9 + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
vec2 u_xlat5;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4 = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4 = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat12 = _TimeScale * _Noise01_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat9.x = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat12 + u_xlat1.x;
    u_xlat2.y = _Time.y * u_xlat9.x + u_xlat1.y;
    u_xlatb1 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat2.xy = (u_xlatb1.x) ? u_xlat10.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat2.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb12 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat12 = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12 = (u_xlatb1.w) ? u_xlat2.z : u_xlat12;
    u_xlat12 = (u_xlatb1.z) ? u_xlat2.y : u_xlat12;
    u_xlat12 = (u_xlatb1.y) ? u_xlat2.x : u_xlat12;
    u_xlat12 = u_xlat12 * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.x = _TimeScale * _Noise02_Uspeed;
    u_xlat5.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat13 = _TimeScale * _Noise02_Vspeed;
    u_xlat1.x = _Time.y * u_xlat1.x + u_xlat5.x;
    u_xlat1.y = _Time.y * u_xlat13 + u_xlat5.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat9.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlat1.xy = (u_xlatb2.x) ? u_xlat9.xy : u_xlat1.xy;
    u_xlat1 = texture(_2ndNoiseTex, u_xlat1.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb2.x = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat13 = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat9.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat13;
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat9.x;
    u_xlat1.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat1.x = u_xlat1.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat12 = u_xlat12 + u_xlat1.x;
    u_xlat10_1 = texture(_ShapeTex, u_xlat0.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBlueBrightness;
    u_xlat12 = u_xlat12 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb1.x = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat4.x = u_xlat0.y * _VcoordMultiplier + (-u_xlat12);
    u_xlat0.z = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.z = min(max(u_xlat0.z, 0.0), 1.0);
#else
    u_xlat0.z = clamp(u_xlat0.z, 0.0, 1.0);
#endif
    u_xlat10_0.xyw = texture(_ShapeTex, u_xlat0.xz).xyw;
    u_xlat0.x = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb12 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat1.x = u_xlat0.x + vs_COLOR0.w;
    u_xlat0.x = (u_xlatb12) ? u_xlat1.x : u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _ColorInner.xyz;
    u_xlat0.x = u_xlat0.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat0.x * u_xlat10_0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8 = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat8) + 1.0;
    u_xlat4.x = u_xlat4.x * u_xlat12 + u_xlat8;
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat4.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0.x = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat0.x) + u_xlat5.x;
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	vec4 _ColorInner;
uniform 	vec4 _ColorOutter;
uniform 	mediump float _LerpAddAlphaToggle;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	vec4 _DayColor;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesFire_CommomArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesFire_Commom {
	miHoYoParticlesFire_CommomArray_Type miHoYoParticlesFire_CommomArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
bool u_xlatb5;
vec2 u_xlat10;
lowp float u_xlat10_10;
bool u_xlatb10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat5.x = _TimeScale * _Noise01_Uspeed;
    u_xlat10.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat16 = _TimeScale * _Noise01_Vspeed;
    u_xlat2.x = _Time.y * u_xlat5.x + u_xlat10.x;
    u_xlat2.y = _Time.y * u_xlat16 + u_xlat10.y;
    u_xlatb3 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlat5.xy = (u_xlatb3.x) ? u_xlat5.xy : u_xlat2.xy;
    u_xlat2 = texture(_NoiseTex01, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb5 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat2.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat10.x = _TimeScale * _Noise02_Uspeed;
    u_xlat2.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat15 = _TimeScale * _Noise02_Vspeed;
    u_xlat3.x = _Time.y * u_xlat10.x + u_xlat2.x;
    u_xlat3.y = _Time.y * u_xlat15 + u_xlat2.y;
    u_xlatb2 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = vec2(u_xlat3.x + vs_TEXCOORD0.z, u_xlat3.y + vs_TEXCOORD0.w);
    u_xlat10.xy = (u_xlatb2.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_2ndNoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb10 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat10.x = u_xlatb10 ? u_xlat3.w : float(0.0);
    u_xlat10.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat10.x;
    u_xlat10.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat10.x;
    u_xlat10.x = u_xlat10.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat5.x = u_xlat10.x + u_xlat5.x;
    u_xlat10_10 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat10.x = u_xlat10_10 * _ShapeBlueBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb10 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat15 = u_xlat1.y * _VcoordMultiplier + (-u_xlat5.x);
    u_xlat1.z = (u_xlatb10) ? u_xlat5.x : u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_5.xyz = texture(_ShapeTex, u_xlat1.xz).xyw;
    u_xlat5.x = u_xlat10_5.z * u_xlat10_5.z + u_xlat10_5.x;
    u_xlat1.xy = vs_COLOR0.xy * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_LerpAddAlphaToggle==1.0);
#else
    u_xlatb15 = _LerpAddAlphaToggle==1.0;
#endif
    u_xlat16 = vs_COLOR0.w * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + u_xlat5.x;
    u_xlat5.x = (u_xlatb15) ? u_xlat16 : u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInner.xyz) + _ColorOutter.xyz;
    u_xlat2.xyz = u_xlat5.xxx * u_xlat2.xyz + _ColorInner.xyz;
    u_xlat5.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat5.x = u_xlat5.x * u_xlat10_5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-vs_COLOR0.w) * miHoYoParticlesFire_CommomArray[u_xlati0]._MeshParticleColorArray.w + 1.0;
    u_xlat0 = u_xlat16_4 + _GrassFireBurnOut;
    u_xlat0 = (-u_xlat0) + u_xlat5.x;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = u_xlat0 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10.x) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10.x;
    u_xlat1.xyz = u_xlat1.yyy * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0;
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
Keywords { "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 118191
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
  GpuProgramID 138909
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-vs_COLOR0.w) + 1.0;
    u_xlat4.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat4.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
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
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _ShapeTex_ST;
uniform 	mediump float _NoiseAsVcoordToggle;
uniform 	float _VcoordMultiplier;
uniform 	float _ShapeBlueBrightness;
uniform 	mediump float _Noise01ChannelSwitch;
uniform 	mediump float _Noise01_RandomToggle;
uniform 	float _Noise01_Uspeed;
uniform 	float _TimeScale;
uniform 	vec4 _NoiseTex01_ST;
uniform 	float _Noise01_Vspeed;
uniform 	float _NoiseTex01Brightness;
uniform 	float _NoiseTex01Offset;
uniform 	mediump float _2ndNoiseChannelSwitch;
uniform 	mediump float _2ndNoise_RandomToggle;
uniform 	float _Noise02_Uspeed;
uniform 	vec4 _2ndNoiseTex_ST;
uniform 	float _Noise02_Vspeed;
uniform 	float _2ndNoiseTexBrightness;
uniform 	float _2ndNoiseTexOffset;
uniform 	float _AlphaEdgeFade;
uniform 	float _GrassFireBurnOut;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex01;
uniform lowp sampler2D _2ndNoiseTex;
uniform lowp sampler2D _ShapeTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
lowp float u_xlat10_4;
int u_xlati4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
bool u_xlatb8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Noise01ChannelSwitch==3.0);
#else
    u_xlatb0 = _Noise01ChannelSwitch==3.0;
#endif
    u_xlat4.x = _TimeScale * _Noise01_Uspeed;
    u_xlat8.xy = vs_TEXCOORD0.xy * _NoiseTex01_ST.xy + _NoiseTex01_ST.zw;
    u_xlat1.x = _Time.y * u_xlat4.x + u_xlat8.x;
    u_xlat4.x = _TimeScale * _Noise01_Vspeed;
    u_xlat1.y = _Time.y * u_xlat4.x + u_xlat8.y;
    u_xlat4.xy = vec2(u_xlat1.x + vs_TEXCOORD0.z, u_xlat1.y + vs_TEXCOORD0.w);
    u_xlatb2 = equal(vec4(_Noise01_RandomToggle, _Noise01ChannelSwitch, _Noise01ChannelSwitch, _Noise01ChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex01, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _NoiseTex01Brightness + (-_NoiseTex01Offset);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_2ndNoiseChannelSwitch==3.0);
#else
    u_xlatb4 = _2ndNoiseChannelSwitch==3.0;
#endif
    u_xlat8.x = _TimeScale * _Noise02_Uspeed;
    u_xlat1.xy = vs_TEXCOORD0.xy * _2ndNoiseTex_ST.xy + _2ndNoiseTex_ST.zw;
    u_xlat2.x = _Time.y * u_xlat8.x + u_xlat1.x;
    u_xlat8.x = _TimeScale * _Noise02_Vspeed;
    u_xlat2.y = _Time.y * u_xlat8.x + u_xlat1.y;
    u_xlat8.xy = vec2(u_xlat2.x + vs_TEXCOORD0.z, u_xlat2.y + vs_TEXCOORD0.w);
    u_xlatb1 = equal(vec4(_2ndNoise_RandomToggle, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch, _2ndNoiseChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.xy = (u_xlatb1.x) ? u_xlat8.xy : u_xlat2.xy;
    u_xlat2 = texture(_2ndNoiseTex, u_xlat8.xy);
    u_xlat4.x = u_xlatb4 ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat2.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _2ndNoiseTexBrightness + (-_2ndNoiseTexOffset);
    u_xlat0.x = u_xlat4.x + u_xlat0.x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeTex_ST.xy + _ShapeTex_ST.zw;
    u_xlat10_4 = texture(_ShapeTex, u_xlat1.xy).z;
    u_xlat4.x = u_xlat10_4 * _ShapeBlueBrightness;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = u_xlat1.y * _VcoordMultiplier + (-u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_NoiseAsVcoordToggle==1.0);
#else
    u_xlatb8 = _NoiseAsVcoordToggle==1.0;
#endif
    u_xlat1.z = (u_xlatb8) ? u_xlat0.x : u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.z = min(max(u_xlat1.z, 0.0), 1.0);
#else
    u_xlat1.z = clamp(u_xlat1.z, 0.0, 1.0);
#endif
    u_xlat10_0 = texture(_ShapeTex, u_xlat1.xz).y;
    u_xlat4.x = u_xlat1.z * _AlphaEdgeFade;
    u_xlat0.x = u_xlat4.x * u_xlat10_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat16_3 = (-vs_COLOR0.w) * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w + 1.0;
    u_xlat4.x = vs_COLOR0.x * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.x;
    u_xlat8.x = u_xlat16_3 + _GrassFireBurnOut;
    u_xlat0.x = (-u_xlat8.x) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat8.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat8.x * u_xlat12 + u_xlat4.x;
    u_xlat16_3 = u_xlat0.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat8.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat8.xy = u_xlat8.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat8.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati8.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati8.xy = (-u_xlati8.xy) + u_xlati1.xy;
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
Keywords { "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_2NDNOISETEXTOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}