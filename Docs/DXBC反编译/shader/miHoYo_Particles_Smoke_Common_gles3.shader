//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/Smoke_Common" {
Properties {
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_RimColor ("RimColor", Color) = (0.5441177,0.5441177,0.5441177,0)
_SmokeBrightness ("SmokeBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_SmokeShapeTex ("SmokeShapeTex", 2D) = "white" { }
_DistortionTex ("DistortionTex", 2D) = "white" { }
_SwirlItensity ("SwirlItensity", Float) = 0.05
_NoiseTex ("NoiseTex", 2D) = "white" { }
_DissolveDistortionNoiseTex ("DissolveDistortionNoiseTex", 2D) = "black" { }
_DissolveDistortionNoise_USpeed ("DissolveDistortionNoise_USpeed", Float) = 0
_DissolveDistortionNoise_VSpeed ("DissolveDistortionNoise_VSpeed", Float) = 0
_DistortionNoiseBrightness ("DistortionNoiseBrightness", Float) = 0
[Toggle(_FIRETOGGLE_ON)] _FireToggle ("FireToggle", Float) = 0
_FireColor ("FireColor", Color) = (1,0.8985802,0.08088237,0)
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
[MHYToggle] _CustomeFireColorToggle ("CustomeFireColorToggle", Float) = 0
_FireNoiseTex ("FireNoiseTex", 2D) = "white" { }
_DayColor ("DayColor", Color) = (1,1,1,1)
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
  GpuProgramID 37814
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_4 = u_xlat16_4 * u_xlat10_1.z;
    u_xlat4.x = u_xlat16_4 * vs_COLOR0.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xyz = _RimColor.xyz * u_xlat10_1.yyy + u_xlat1.xzw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.w;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_1.w;
    u_xlat4.x = u_xlat16_4 * vs_COLOR0.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * u_xlat1.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.z;
    u_xlat4.x = u_xlat16_4 * u_xlat1.y;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat5.xyz = u_xlat10_2.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat5.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
int u_xlati12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
    u_xlat0.x = u_xlat16_0 * u_xlat1.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.w;
    u_xlat4.x = u_xlat16_4 * u_xlat1.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
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
    u_xlat5 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat5 + u_xlat12;
    u_xlat1.w = u_xlat12 * u_xlat0.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.w;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
void main()
{
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_1.w;
    u_xlat4.x = u_xlat16_4 * vs_COLOR0.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * u_xlat1.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
void main()
{
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.z;
    u_xlat4.x = u_xlat16_4 * u_xlat1.y;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat5.xyz = u_xlat10_2.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat5.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
int u_xlati12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
    u_xlat0.x = u_xlat16_0 * u_xlat1.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.w;
    u_xlat4.x = u_xlat16_4 * u_xlat1.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat1.w = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat10 = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat10 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat6;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyw * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
float u_xlat10;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyw * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat1.w = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat12 = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat7 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat13 + u_xlat7;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat12 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat1.w = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat10 = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat10 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat6;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyw * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
float u_xlat10;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyw * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat1.w = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat12 = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat7 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat13 + u_xlat7;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat12 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_4 = u_xlat16_4 * u_xlat10_1.z;
    u_xlat4.x = u_xlat16_4 * vs_COLOR0.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xyz = _RimColor.xyz * u_xlat10_1.yyy + u_xlat1.xzw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.yyy;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.w;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_1.w;
    u_xlat4.x = u_xlat16_4 * vs_COLOR0.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * u_xlat1.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.z;
    u_xlat4.x = u_xlat16_4 * u_xlat1.y;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat5.xyz = u_xlat10_2.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat5.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
int u_xlati12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
    u_xlat0.x = u_xlat16_0 * u_xlat1.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.w;
    u_xlat4.x = u_xlat16_4 * u_xlat1.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
float u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat12 = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
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
    u_xlat5 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat1.x * u_xlat5 + u_xlat12;
    u_xlat1.w = u_xlat12 * u_xlat0.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.yyy;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.w;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
void main()
{
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_3.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_1.w;
    u_xlat4.x = u_xlat16_4 * vs_COLOR0.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat2.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat2.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
    u_xlat2.xy = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_2 = texture(_FireNoiseTex, u_xlat2.xy).x;
    u_xlat16_5 = u_xlat10_1.y * u_xlat10_2;
    u_xlat16_5 = u_xlat16_5 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_5) + u_xlat1.xzw;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec3 u_xlat10_4;
vec3 u_xlat5;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.z;
    u_xlat0.x = u_xlat16_0 * u_xlat1.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat2.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat0.xyw = u_xlat10_4.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat0.xyz = _RimColor.xyz * u_xlat10_4.yyy + u_xlat0.xyw;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_SmokeBrightness);
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec3 u_xlat5;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
void main()
{
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xyz = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.z * 1.39999998 + -0.5;
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2.xyz = texture(_SmokeShapeTex, u_xlat2.xz).xzw;
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.z;
    u_xlat4.x = u_xlat16_4 * u_xlat1.y;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat5.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat5.xyz = u_xlat10_2.xxx * u_xlat5.xyz + _DarkColor.xyz;
    u_xlat5.xyz = _RimColor.xyz * u_xlat10_2.yyy + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
int u_xlati12;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati12]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_2.w;
    u_xlat0.x = u_xlat16_0 * u_xlat1.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp float u_xlat10_4;
vec2 u_xlat8;
mediump vec2 u_xlat16_8;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_13;
lowp float u_xlat10_13;
void main()
{
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat4.y;
    u_xlat10_4 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat8.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_8.xy = texture(_DistortionTex, u_xlat8.xy).xy;
    u_xlat16_8.xy = u_xlat10_8.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_8.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_8.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_4) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_4 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlati1 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati1]._MeshParticleColorArray;
    u_xlat16_3.xy = u_xlat1.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_4 = u_xlat10_4 + (-u_xlat16_3.y);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_8.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_2 = texture(_SmokeShapeTex, u_xlat2.xz);
    u_xlat16_4 = u_xlat16_4 * u_xlat10_2.w;
    u_xlat4.x = u_xlat16_4 * u_xlat1.z;
    u_xlat4.x = u_xlat4.x * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_2.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_2.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xyz = u_xlat1.yyy * u_xlat1.xzw;
    u_xlat2.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_13 = texture(_FireNoiseTex, u_xlat2.xz).x;
    u_xlat16_13 = u_xlat10_2.y * u_xlat10_13;
    u_xlat16_13 = u_xlat16_13 * 7.0 + (-u_xlat16_3.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb2 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb2)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat16_13) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat1.w = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat10 = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat10 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat6;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyw * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
float u_xlat10;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyw * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat1.w = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat12 = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat7 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat13 + u_xlat7;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat12 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
mediump float u_xlat16_10;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat1.w = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat10;
mediump float u_xlat16_10;
float u_xlat11;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0.xyz = texture(_SmokeShapeTex, u_xlat0.xz).xzw;
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_0.yyy + u_xlat1.xzw;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat0.xyw * vs_COLOR0.yyy;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_4 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_1.x = u_xlat10_1.x + (-u_xlat16_4);
    u_xlat16_10 = u_xlat10_0.z * u_xlat16_1.x;
    u_xlat10 = u_xlat16_10 * vs_COLOR0.z;
    u_xlat10 = u_xlat10 * _AlphaBrightness;
    u_xlat10 = u_xlat10 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat10 * u_xlat1.x;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat1.w = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec2 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec2 u_xlat16_4;
float u_xlat6;
float u_xlat11;
float u_xlat15;
mediump float u_xlat16_15;
lowp float u_xlat10_16;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_1.xy = texture(_DistortionTex, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_1.x * _SwirlItensity;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat0.xy = u_xlat16_1.xy * vec2(_SwirlItensity) + u_xlat0.xz;
    u_xlat0.z = (-u_xlat0.y) + 1.0;
    u_xlat10_0 = texture(_SmokeShapeTex, u_xlat0.xz);
    u_xlat1.xzw = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat1.xzw = u_xlat10_0.xxx * u_xlat1.xzw + _DarkColor.xyz;
    u_xlat1.xzw = _RimColor.xyz * u_xlat10_0.zzz + u_xlat1.xzw;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_SmokeBrightness);
    u_xlat1.xzw = u_xlat1.xzw * vs_COLOR0.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb0.x = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (u_xlatb0.x) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_0.x = texture(_FireNoiseTex, u_xlat0.xz).x;
    u_xlat16_0 = u_xlat10_0.y * u_xlat10_0.x;
    u_xlat16_4.xy = vs_COLOR0.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_0 = u_xlat16_0 * 7.0 + (-u_xlat16_4.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat3.xyz * vec3(u_xlat16_0) + u_xlat1.xzw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_1.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_16 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_16) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_1.x = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_1.x = (-u_xlat16_4.y) + u_xlat10_1.x;
    u_xlat16_15 = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat15 = u_xlat16_15 * vs_COLOR0.z;
    u_xlat15 = u_xlat15 * _AlphaBrightness;
    u_xlat15 = u_xlat15 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat11 = (-u_xlat6) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat11 + u_xlat6;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat2.w = u_xlat15 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat1.xyw * _DayColor.xyz;
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec2 u_xlat5;
mediump vec2 u_xlat16_5;
lowp vec2 u_xlat10_5;
float u_xlat10;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat5.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_5.xy = texture(_DistortionTex, u_xlat5.xy).xy;
    u_xlat16_5.xy = u_xlat10_5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_5.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_5.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1.xyz = texture(_SmokeShapeTex, u_xlat1.xz).xzw;
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat0.xyw = vec3(vs_COLOR0.y * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.y, vs_COLOR0.z * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray.w);
    u_xlat1.xyw = _RimColor.xyz * u_xlat10_1.yyy + u_xlat3.xyz;
    u_xlat1.xyw = u_xlat1.xyw * vec3(_SmokeBrightness);
    u_xlat1.xyw = u_xlat0.xxx * u_xlat1.xyw;
    u_xlat3.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.z = u_xlat16_5.y * _SwirlItensity + (-u_xlat3.y);
    u_xlat2.z = 1.0;
    u_xlat2.xy = u_xlat2.xz + u_xlat3.xz;
    u_xlat0.xz = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.z;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat0.xz = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat2.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xz).x;
    u_xlat16_4 = u_xlat0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_4);
    u_xlat16_0 = u_xlat16_0 * u_xlat10_1.z;
    u_xlat0.x = u_xlat16_0 * u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
    u_xlat0.x = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat10 = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat10) + 1.0;
    u_xlat5.x = u_xlat5.x * u_xlat15 + u_xlat10;
    u_xlat1.xyz = u_xlat1.xyw * _DayColor.xyz;
    u_xlat1.w = u_xlat5.x * u_xlat0.x;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec3 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat1.w = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyw * _DayColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
uniform 	vec4 _DarkColor;
uniform 	vec4 _LightColor;
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _RimColor;
uniform 	float _SmokeBrightness;
uniform 	mediump float _CustomeFireColorToggle;
uniform 	vec4 _FireColor;
uniform 	vec4 _FireNoiseTex_ST;
uniform 	vec4 _DayColor;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoParticlesSmoke_CommonArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesSmoke_Common {
	miHoYoParticlesSmoke_CommonArray_Type miHoYoParticlesSmoke_CommonArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _FireNoiseTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
lowp vec2 u_xlat10_6;
float u_xlat7;
float u_xlat12;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
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
    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat6.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_6.xy = texture(_DistortionTex, u_xlat6.xy).xy;
    u_xlat16_6.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = u_xlat16_6.x * _SwirlItensity;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_6.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_1 = texture(_SmokeShapeTex, u_xlat1.xz);
    u_xlat3.xyz = (-_DarkColor.xyz) + _LightColor.xyz;
    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat3.xyz + _DarkColor.xyz;
    u_xlat4 = vs_COLOR0 * miHoYoParticlesSmoke_CommonArray[u_xlati0]._MeshParticleColorArray;
    u_xlat0.xyw = _RimColor.xyz * u_xlat10_1.zzz + u_xlat3.xyz;
    u_xlat0.xyw = u_xlat0.xyw * vec3(_SmokeBrightness);
    u_xlat0.xyw = u_xlat4.yyy * u_xlat0.xyw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_CustomeFireColorToggle==1.0);
#else
    u_xlatb1 = _CustomeFireColorToggle==1.0;
#endif
    u_xlat3.xyz = (bool(u_xlatb1)) ? vs_TEXCOORD1.xyz : _FireColor.xyz;
    u_xlat1.xz = vs_TEXCOORD0.xy * _FireNoiseTex_ST.xy + _FireNoiseTex_ST.zw;
    u_xlat10_1.x = texture(_FireNoiseTex, u_xlat1.xz).x;
    u_xlat16_1 = u_xlat10_1.y * u_xlat10_1.x;
    u_xlat16_5.xy = u_xlat4.xw * vec2(4.5999999, 1.39999998) + vec2(-0.600000024, -0.5);
    u_xlat16_1 = u_xlat16_1 * 7.0 + (-u_xlat16_5.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat0.xyw = u_xlat3.xyz * vec3(u_xlat16_1) + u_xlat0.xyw;
    u_xlat1.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.z = u_xlat16_6.y * _SwirlItensity + (-u_xlat1.y);
    u_xlat2.z = 1.0;
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat2.x;
    u_xlat3.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat2.y;
    u_xlat10_12 = texture(_DissolveDistortionNoiseTex, u_xlat3.xy).x;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = vec2(u_xlat10_12) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_12 = texture(_NoiseTex, u_xlat1.xy).x;
    u_xlat16_12 = (-u_xlat16_5.y) + u_xlat10_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat10_1.w;
    u_xlat12 = u_xlat16_12 * u_xlat4.z;
    u_xlat12 = u_xlat12 * _AlphaBrightness;
    u_xlat12 = u_xlat12 * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat7 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat7) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat13 + u_xlat7;
    u_xlat2.xyz = u_xlat0.xyw * _DayColor.xyz;
    u_xlat2.w = u_xlat12 * u_xlat1.x;
    SV_Target0 = u_xlat2;
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
Keywords { "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "INSTANCING_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_FIRETOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_SOFTPARTICLES_ON" "_FIRETOGGLE_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 111178
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
  GpuProgramID 173246
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat1.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat1.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vec2(vs_COLOR0.z * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.y * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat2.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vec2(vs_COLOR0.z * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.y * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat2.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat1.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlat16_3 = vs_COLOR0.w * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat1.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat1.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat1.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * vs_COLOR0.z;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vec2(vs_COLOR0.z * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.y * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat2.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
uniform 	vec4 _SmokeShapeTex_ST;
uniform 	float _SwirlItensity;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _DissolveDistortionNoise_USpeed;
uniform 	vec4 _DissolveDistortionNoiseTex_ST;
uniform 	float _DissolveDistortionNoise_VSpeed;
uniform 	float _DistortionNoiseBrightness;
uniform 	float _AlphaBrightness;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _SmokeShapeTex;
uniform lowp sampler2D _DissolveDistortionNoiseTex;
uniform lowp sampler2D _NoiseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
bool u_xlatb0;
vec3 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
lowp vec2 u_xlat10_4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
int u_xlati12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DissolveDistortionNoiseTex_ST.xy + _DissolveDistortionNoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _DissolveDistortionNoise_USpeed + u_xlat0.x;
    u_xlat1.y = _Time.y * _DissolveDistortionNoise_VSpeed + u_xlat0.y;
    u_xlat10_0 = texture(_DissolveDistortionNoiseTex, u_xlat1.xy).x;
    u_xlat1.z = 1.0;
    u_xlat4.xy = vs_TEXCOORD0.xy * vec2(1.0, 2.0);
    u_xlat10_4.xy = texture(_DistortionTex, u_xlat4.xy).xy;
    u_xlat16_4.xy = u_xlat10_4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat16_4.x * _SwirlItensity;
    u_xlat2.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat2.z = u_xlat16_4.y * _SwirlItensity + (-u_xlat2.y);
    u_xlat1.xy = u_xlat1.xz + u_xlat2.xz;
    u_xlat1.z = (-u_xlat1.y) + 1.0;
    u_xlat0.xw = vec2(u_xlat10_0) * vec2(vec2(_DistortionNoiseBrightness, _DistortionNoiseBrightness)) + u_xlat1.xz;
    u_xlat10_0 = texture(_NoiseTex, u_xlat0.xw).x;
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1.xy = vec2(vs_COLOR0.z * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.z, vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati12]._MeshParticleColorArray.w);
    u_xlat16_3 = u_xlat1.y * 1.39999998 + -0.5;
    u_xlat16_0 = u_xlat10_0 + (-u_xlat16_3);
    u_xlat2.xy = vs_TEXCOORD0.xy * _SmokeShapeTex_ST.xy + _SmokeShapeTex_ST.zw;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat2.xy = u_xlat16_4.xy * vec2(_SwirlItensity) + u_xlat2.xz;
    u_xlat2.z = (-u_xlat2.y) + 1.0;
    u_xlat10_4.x = texture(_SmokeShapeTex, u_xlat2.xz).w;
    u_xlat16_0 = u_xlat16_0 * u_xlat10_4.x;
    u_xlat0.x = u_xlat16_0 * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _AlphaBrightness;
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
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}