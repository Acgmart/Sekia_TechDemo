//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/OneChannel" {
Properties {
_MainColor ("MainColor", Color) = (0.5019608,0.5019608,0.5019608,0.5019608)
_ColorBrightness ("ColorBrightness", Range(0, 50)) = 1
_AlphaBrightness ("AlphaBrightness", Range(0, 50)) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3,White,4)] _BaseTexAlphaChannelSwitch ("BaseTexAlphaChannelSwitch", Float) = 0
[MHYToggle] _UseCustom2ColorToggle ("UseCustom2ColorToggle", Float) = 0
[Enum(R,0,G,1,B,2,A,3,White,4)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 1
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_ParticleCustomProp0 ("_ParticleCustomProp0", Vector) = (1,1,1,1)
_ParticleCustomProp1 ("_ParticleCustomProp1", Vector) = (1,1,1,1)
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
  GpuProgramID 6601
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat1 = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = (u_xlatb3.w) ? u_xlat2.w : u_xlat1;
    u_xlat1 = (u_xlatb3.z) ? u_xlat2.z : u_xlat1;
    u_xlat1 = (u_xlatb3.y) ? u_xlat2.y : u_xlat1;
    u_xlat1 = (u_xlatb3.x) ? u_xlat2.x : u_xlat1;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat1 = u_xlat1 * u_xlat5;
    u_xlat1 = dot(vec2(u_xlat1), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1 * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat12 = u_xlat1.w * _MainColor.w;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat1 = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = (u_xlatb3.w) ? u_xlat2.w : u_xlat1;
    u_xlat1 = (u_xlatb3.z) ? u_xlat2.z : u_xlat1;
    u_xlat1 = (u_xlatb3.y) ? u_xlat2.y : u_xlat1;
    u_xlat1 = (u_xlatb3.x) ? u_xlat2.x : u_xlat1;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat1 = u_xlat1 * u_xlat5;
    u_xlat1 = dot(vec2(u_xlat1), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1 * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat12 = u_xlat1.w * _MainColor.w;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.x = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
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
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
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
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.x = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
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
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
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
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat1 = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = (u_xlatb3.w) ? u_xlat2.w : u_xlat1;
    u_xlat1 = (u_xlatb3.z) ? u_xlat2.z : u_xlat1;
    u_xlat1 = (u_xlatb3.y) ? u_xlat2.y : u_xlat1;
    u_xlat1 = (u_xlatb3.x) ? u_xlat2.x : u_xlat1;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat1 = u_xlat1 * u_xlat5;
    u_xlat1 = dot(vec2(u_xlat1), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1 * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_TEXCOORD3.www;
    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat12 = u_xlat1.w * _MainColor.w;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_TEXCOORD3.www;
    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
float u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat1 = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1 = (u_xlatb3.w) ? u_xlat2.w : u_xlat1;
    u_xlat1 = (u_xlatb3.z) ? u_xlat2.z : u_xlat1;
    u_xlat1 = (u_xlatb3.y) ? u_xlat2.y : u_xlat1;
    u_xlat1 = (u_xlatb3.x) ? u_xlat2.x : u_xlat1;
    u_xlat5 = vs_COLOR0.w * _MainColor.w;
    u_xlat1 = u_xlat1 * u_xlat5;
    u_xlat1 = dot(vec2(u_xlat1), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat1 * _DayColor.w;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _ProjectionParams;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec2 u_xlat8;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlat8.x = vs_COLOR0.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb1.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat1.x = u_xlatb1.x ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat1.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat1.x;
    u_xlat5.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat5.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_TEXCOORD3.www;
    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat4.xy);
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat16_4.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb12 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyz : _MainColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_ColorBrightness);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati12]._MeshParticleColorArray;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat12 = u_xlat1.w * _MainColor.w;
    u_xlat0.xyz = u_xlat0.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb3.w) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
int u_xlati8;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat0.x = texture(_CameraDepthTextureScaled, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat4 = u_xlat0.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat4 * u_xlat8.x + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat2 = texture(_BaseTex, u_xlat8.xy);
    u_xlat4 = (u_xlatb1.w) ? u_xlat2.w : u_xlat4;
    u_xlat4 = (u_xlatb1.z) ? u_xlat2.z : u_xlat4;
    u_xlat4 = (u_xlatb1.y) ? u_xlat2.y : u_xlat4;
    u_xlat4 = (u_xlatb1.x) ? u_xlat2.x : u_xlat4;
    u_xlati8 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati8]._MeshParticleColorArray;
    u_xlat8.x = u_xlat1.w * _MainColor.w;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.w = u_xlat0.x * _DayColor.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb13 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlatb3 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = (u_xlatb3.w) ? u_xlat2.w : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat2.z : u_xlat13;
    u_xlat13 = (u_xlatb3.y) ? u_xlat2.y : u_xlat13;
    u_xlat13 = (u_xlatb3.x) ? u_xlat2.x : u_xlat13;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb13 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat2.xyz = (bool(u_xlatb13)) ? u_xlat2.xyz : _MainColor.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vs_TEXCOORD3.www;
    u_xlat0.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTexture, u_xlat3.xy).x;
    u_xlat3.x = _ZBufferParams.z * u_xlat3.x + _ZBufferParams.w;
    u_xlat3.x = float(1.0) / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.x = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
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
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat1.x = u_xlat1.x + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_TEXCOORD3.www;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    u_xlat1.xyz = u_xlat4.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat3.xyz + u_xlat3.xyz;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
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
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
float u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
float u_xlat9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlatb0.xy = equal(unity_DebugViewInfo.xxxx, vec4(100.0, 102.0, 0.0, 0.0)).xy;
    u_xlatb0.x = u_xlatb0.y || u_xlatb0.x;
    if(u_xlatb0.x){
        SV_Target0 = vec4(0.100000001, 0.100000001, 0.100000001, 0.0);
        return;
    //ENDIF
    }
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0 = texture(_BaseTex, u_xlat0.xy);
    u_xlatb1 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb2.x = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat2 = u_xlatb2.x ? 1.0 : float(0.0);
    u_xlat10 = (u_xlatb1.w) ? u_xlat0.w : u_xlat2;
    u_xlat7 = (u_xlatb1.z) ? u_xlat0.z : u_xlat10;
    u_xlat4.x = (u_xlatb1.y) ? u_xlat0.y : u_xlat7;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat4.xyz = (-vs_TEXCOORD1.xyz) + vs_TEXCOORD2.xyz;
    u_xlat1.xyz = u_xlat1.xxx * u_xlat4.xyz + vs_TEXCOORD1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb10 = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat1.xyz : _MainColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb10 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat10 = u_xlatb10 ? 1.0 : float(0.0);
    u_xlat9 = (u_xlatb2.w) ? u_xlat0.w : u_xlat10;
    u_xlat6 = (u_xlatb2.z) ? u_xlat0.z : u_xlat9;
    u_xlat3.x = (u_xlatb2.y) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat3.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat3.x = texture(_CameraDepthTextureScaled, u_xlat3.xy).x;
    u_xlat3.x = u_xlat3.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat6 = u_xlat3.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat3.x = u_xlat3.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat6) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat6;
    u_xlat6 = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat3.xyz = u_xlat3.xyz * vs_COLOR0.xyz;
    u_xlat3.xyz = u_xlat3.xyz * _DayColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www;
    u_xlat1.w = u_xlat0.x * _DayColor.w;
    u_xlat1.xyz = u_xlat3.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.x = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat1.x;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
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
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat1.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _HeigtFogParams2;
uniform 	vec4 _HeigtFogTopColor;
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
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
bool u_xlatb9;
mediump float u_xlat16_10;
float u_xlat14;
float u_xlat16;
float u_xlat23;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat0.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat2.x = u_xlat0.z * _HeigtFogParams.x;
    u_xlat9 = u_xlat2.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.00999999978<abs(u_xlat2.x));
#else
    u_xlatb2 = 0.00999999978<abs(u_xlat2.x);
#endif
    u_xlat16_3.x = (u_xlatb2) ? u_xlat9 : 1.0;
    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat9 = u_xlat2.x * _HeigtFogParams.y;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat9 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat16 = u_xlat9 * -1.44269502;
    u_xlat16 = exp2(u_xlat16);
    u_xlat16 = (-u_xlat16) + 1.0;
    u_xlat16 = u_xlat16 / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_10 = (u_xlatb9) ? u_xlat16 : 1.0;
    u_xlat9 = u_xlat2.x * _HeigtFogParams2.y;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat16_10 = exp2((-u_xlat16_10));
    u_xlat16_3.y = (-u_xlat16_10) + 1.0;
    u_xlat16_3.xy = max(u_xlat16_3.xy, vec2(0.0, 0.0));
    u_xlat16_3.x = u_xlat16_3.y + u_xlat16_3.x;
    u_xlat9 = u_xlat2.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat16_10 = (-u_xlat9) + 2.0;
    u_xlat16_10 = u_xlat9 * u_xlat16_10;
    u_xlat9 = u_xlat16_10 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat9 = u_xlat9 + 1.0;
    u_xlat16_3.x = u_xlat9 * u_xlat16_3.x;
    u_xlat9 = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat16 = (-u_xlat9) + 1.0;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat0.y * _HeigtFogParams2.w + _HeigtFogParams2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat7.xxx * _HeigtFogTopColor.xyz + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat23) + 2.0;
    u_xlat16_3.x = u_xlat23 * u_xlat16_3.x;
    u_xlat5.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7.x = u_xlat2.x + (-_HeigtFogRamp.w);
    u_xlat2.x = u_xlat2.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat7.xxx * u_xlat6.xyz + u_xlat5.xyz;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat6.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat6.xyz);
    u_xlat7.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!((-u_xlat0.x)>=u_xlat7.x);
#else
    u_xlatb0 = (-u_xlat0.x)>=u_xlat7.x;
#endif
    u_xlat7.x = (-u_xlat2.x) + 2.0;
    u_xlat7.x = u_xlat7.x * u_xlat2.x;
    u_xlat14 = u_xlat7.x * _HeigtFogColDelta.w;
    u_xlat0.x = (u_xlatb0) ? u_xlat14 : u_xlat7.x;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogColor.w;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, _HeigtFogColBase.w);
    u_xlat7.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD3.w = u_xlat16 * u_xlat0.x;
    u_xlat0.xyz = vec3(u_xlat16) * u_xlat7.xyz;
    vs_TEXCOORD3.xyz = u_xlat4.xyz * vec3(u_xlat9) + u_xlat0.xyz;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 unity_DebugViewInfo;
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	vec4 _MainColor;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	vec4 _DayColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoParticlesOneChannelArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesOneChannel {
	miHoYoParticlesOneChannelArray_Type miHoYoParticlesOneChannelArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat9;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexColorChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexColorChannelSwitch==4.0);
#else
    u_xlatb4 = _BaseTexColorChannelSwitch==4.0;
#endif
    u_xlat4.x = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat4.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat4.x;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(_UseCustom2ColorToggle==1.0);
#else
    u_xlatb2.x = _UseCustom2ColorToggle==1.0;
#endif
    u_xlat4.xyz = (u_xlatb2.x) ? u_xlat4.xyz : _MainColor.xyz;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesOneChannelArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0.x = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0 = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat0 = (u_xlatb3.w) ? u_xlat1.w : u_xlat0;
    u_xlat0 = (u_xlatb3.z) ? u_xlat1.z : u_xlat0;
    u_xlat0 = (u_xlatb3.y) ? u_xlat1.y : u_xlat0;
    u_xlat0 = (u_xlatb3.x) ? u_xlat1.x : u_xlat0;
    u_xlat1.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat1.x = texture(_CameraDepthTextureScaled, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.x * _ProjectionParams.z + (-vs_TEXCOORD5.w);
    u_xlat5 = u_xlat1.x * _DepthFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x / _DepthThresh;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat9 = (-u_xlat5) + 1.0;
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat5;
    u_xlat5 = u_xlat2.w * _MainColor.w;
    u_xlat0 = u_xlat0 * u_xlat5;
    u_xlat0 = u_xlat1.x * u_xlat0;
    u_xlat0 = dot(vec2(u_xlat0), vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat4.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat4.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _DayColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vs_TEXCOORD3.www;
    u_xlat1.w = u_xlat0 * _DayColor.w;
    u_xlat1.xyz = u_xlat4.xyz * vec3(2.0, 2.0, 2.0) + vs_TEXCOORD3.xyz;
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
Keywords { "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
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
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "EFFECTED_BY_FOG" "_SOFTPARTICLES_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 104411
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
  GpuProgramID 176932
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
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ZBufferParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlat4.x = vs_COLOR0.w * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _AlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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
uniform 	vec4 _ProjectionParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump float _MotionVectorsAlphaCutoff;
uniform 	vec4 _DayColor;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	vec4 _BaseTex_ST;
uniform 	float _DepthFade;
uniform 	float _DepthThresh;
uniform 	float _AlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform highp sampler2D _CameraDepthTextureScaled;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
vec2 u_xlat4;
int u_xlati4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==4.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==4.0;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat1 = texture(_BaseTex, u_xlat4.xy);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat0.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
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
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, vec2(vec2(_AlphaBrightness, _AlphaBrightness)));
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = _DayColor.w * u_xlat0.x + (-_MotionVectorsAlphaCutoff);
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