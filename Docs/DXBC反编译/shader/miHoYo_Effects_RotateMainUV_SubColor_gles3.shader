//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Effects/RotateMainUV_SubColor" {
Properties {
_FadeOut ("FadeOut", Range(0, 1)) = 0
_UseCustomDataParSys ("UseCustomData(ParSys)", Range(0, 1)) = 0
_AlphaScale ("AlphaScale", Float) = 1
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorScale ("ColorScale", Float) = 1
_MainTex ("MainTex", 2D) = "white" { }
_MainChannelNum ("MainChannelNum", Range(0, 4)) = 1
_MainRotateSpeed ("MainRotateSpeed", Float) = 0
_MainTexPannerXY ("MainTexPanner(XY)", Vector) = (0,0,0,0)
_SubColor ("SubColor", Color) = (0,0,0,1)
_SubColorScale ("SubColorScale", Float) = 1
_SubColorThreshold ("SubColorThreshold", Range(-1, 1)) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskChannelNum ("MaskChannelNum", Range(0, 4)) = 1
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
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
  GpuProgramID 50627
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTexture, u_xlat5.xy).x;
    u_xlat5.x = _ZBufferParams.z * u_xlat5.x + _ZBufferParams.w;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat1.x = u_xlat2.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat9;
float u_xlat13;
void main()
{
    u_xlat16_0.x = floor(_UseCustomDataParSys);
    u_xlat16_4.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_0.xy = u_xlat16_0.xx * u_xlat16_4.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat1.x = u_xlat16_0.x * _Time.y;
    u_xlat16_0.x = (-u_xlat16_0.y) + vs_TEXCOORD0.y;
    u_xlat16_2.x = sin(u_xlat1.x);
    u_xlat16_3.x = cos(u_xlat1.x);
    u_xlat1.x = (-u_xlat16_2.x);
    u_xlat16_3.y = u_xlat16_2.x;
    u_xlat1.y = u_xlat16_3.x;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat9.xy = u_xlat9.xy + vec2(-0.5, -0.5);
    u_xlat1.y = dot(u_xlat9.xy, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat9.xy, u_xlat16_3.xy);
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat1.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_2 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_2 = min(abs(u_xlat16_2), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_2 = (-u_xlat16_2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.xy = u_xlat10_1.xy * u_xlat16_2.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_2.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_2.w + u_xlat16_1.x;
    u_xlat16_4.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_4.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_0.x = (-u_xlat16_4.x) + u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + -1.0;
    u_xlat16_0.x = _SubColor.w * u_xlat16_0.x + 1.0;
    u_xlat16_4.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat5.xyz = u_xlat16_4.xyz * vs_COLOR0.xyz;
    u_xlat2 = vs_COLOR0 * _MainColor;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(_ColorScale) + (-u_xlat5.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat5.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_0.xyz;
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat5.x = texture(_CameraDepthTextureScaled, u_xlat5.xy).x;
    u_xlat5.x = u_xlat5.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat9.x = u_xlat5.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat5.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat5.x) + 1.0;
    u_xlat5.x = u_xlat9.x * u_xlat13 + u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat1.x = u_xlat2.w * u_xlat1.x;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTexture, u_xlat7.xy).x;
    u_xlat7.x = _ZBufferParams.z * u_xlat7.x + _ZBufferParams.w;
    u_xlat7.x = float(1.0) / u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
mediump vec3 u_xlat16_10;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat16_0.x;
    SV_Target0.w = u_xlat0.x;
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
uniform 	mediump vec4 _SubColor;
uniform 	mediump float _SubColorScale;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _ColorScale;
uniform 	mediump float _AlphaScale;
uniform 	mediump vec2 _MainTexPannerXY;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _MainRotateSpeed;
uniform 	mediump float _UseCustomDataParSys;
uniform 	mediump float _MainChannelNum;
uniform 	mediump float _SubColorThreshold;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec2 u_xlat2;
mediump vec2 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec4 u_xlat16_4;
vec2 u_xlat5;
vec2 u_xlat6;
vec2 u_xlat7;
mediump vec3 u_xlat16_10;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_21;
mediump float u_xlat16_24;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat16_1.xyz = _SubColor.xyz * vec3(_SubColorScale);
    u_xlat0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat1 = vs_COLOR0 * _MainColor;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_3.x = floor(_UseCustomDataParSys);
    u_xlat16_10.xy = vs_TEXCOORD1.xy + (-vec2(_MainRotateSpeed, _SubColorThreshold));
    u_xlat16_3.xy = u_xlat16_3.xx * u_xlat16_10.xy + vec2(_MainRotateSpeed, _SubColorThreshold);
    u_xlat21 = u_xlat16_3.x * _Time.y;
    u_xlat16_3.x = sin(u_xlat21);
    u_xlat16_4.x = cos(u_xlat21);
    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
    u_xlat5.x = (-u_xlat16_3.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat6.x = dot(u_xlat2.xy, u_xlat16_4.xy);
    u_xlat5.y = u_xlat16_4.x;
    u_xlat6.y = dot(u_xlat2.xy, u_xlat5.xy);
    u_xlat2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat2.xy = _Time.yy * vec2(_MainTexPannerXY.x, _MainTexPannerXY.y) + u_xlat2.xy;
    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_4 = (-vec4(vec4(_MainChannelNum, _MainChannelNum, _MainChannelNum, _MainChannelNum))) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3.x = min(abs(_MainChannelNum), 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_2.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_21 = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_21 = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_21;
    u_xlat16_21 = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_21;
    u_xlat16_21 = u_xlat16_3.x + u_xlat16_21;
    u_xlat16_3.x = (-u_xlat16_3.y) + vs_TEXCOORD0.y;
    u_xlat16_3.x = u_xlat16_21 + (-u_xlat16_3.x);
    u_xlat16_10.x = (-vs_COLOR0.w) * _MainColor.w + 1.0;
    u_xlat16_3.x = (-u_xlat16_10.x) + u_xlat16_3.x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_3.x + -1.0;
    u_xlat16_3.x = _SubColor.w * u_xlat16_3.x + 1.0;
    u_xlat16_10.xyz = u_xlat1.xyz * vec3(_ColorScale) + (-u_xlat0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + u_xlat0.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture(_MaskTex, u_xlat0.xy);
    u_xlat16_4 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_4 = min(abs(u_xlat16_4), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_4 = (-u_xlat16_4) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_24 = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_24 = (-u_xlat16_24) + 1.0;
    u_xlat16_0.xy = u_xlat10_2.xy * u_xlat16_4.xy;
    u_xlat16_0.x = u_xlat16_0.y + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.z * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat10_2.w * u_xlat16_4.w + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_24 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat7.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat7.x = texture(_CameraDepthTextureScaled, u_xlat7.xy).x;
    u_xlat7.x = u_xlat7.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat14 = u_xlat7.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
#else
    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat14) + 1.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x + u_xlat14;
    SV_Target0.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat7.x * u_xlat16_0.x;
    u_xlat16_3.x = (-_FadeOut) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = u_xlat1.w * u_xlat0.x;
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
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 74937
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
  GpuProgramID 193904
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
float u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat4 + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
float u_xlat10;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat7.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat7.x * u_xlat10 + u_xlat4.x;
    u_xlat1.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat1.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
float u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat4 + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
float u_xlat10;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTexture, u_xlat4.xy).x;
    u_xlat4.x = _ZBufferParams.z * u_xlat4.x + _ZBufferParams.w;
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat4.x = u_xlat4.x + (-vs_TEXCOORD5.w);
    u_xlat7.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat7.x * u_xlat10 + u_xlat4.x;
    u_xlat1.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat1.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
float u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat4 + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
float u_xlat10;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat7.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat7.x * u_xlat10 + u_xlat4.x;
    u_xlat1.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat1.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
float u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x * u_xlat16_1.x;
    u_xlat4 = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat16_1.x * u_xlat4 + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskChannelNum;
uniform 	mediump float _AlphaScale;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	mediump float _FadeOut;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _MaskTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
ivec2 u_xlati2;
vec2 u_xlat4;
vec2 u_xlat7;
ivec2 u_xlati7;
float u_xlat10;
void main()
{
    u_xlat16_0 = (-vec4(_MaskChannelNum)) + vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat16_0 = min(abs(u_xlat16_0), vec4(1.0, 1.0, 1.0, 1.0));
    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat16_1.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_1.x = u_xlat16_1.y + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.z * u_xlat16_0.z + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_1.w * u_xlat16_0.w + u_xlat16_1.x;
    u_xlat16_0.x = min(abs(_MaskChannelNum), 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * _AlphaScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat4.x = texture(_CameraDepthTextureScaled, u_xlat4.xy).x;
    u_xlat4.x = u_xlat4.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat7.x = u_xlat4.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat10 = (-u_xlat4.x) + 1.0;
    u_xlat4.x = u_xlat7.x * u_xlat10 + u_xlat4.x;
    u_xlat1.x = u_xlat4.x * u_xlat16_1.x;
    u_xlat16_0.x = (-_FadeOut) + 1.0;
    u_xlat1.x = u_xlat16_0.x * u_xlat1.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat16_0.x = u_xlat1.x * u_xlat4.x + (-_MotionVectorsAlphaCutoff);
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