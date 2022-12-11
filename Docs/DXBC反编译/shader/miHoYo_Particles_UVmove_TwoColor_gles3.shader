//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/Particles/UVmove_TwoColor" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
[Enum(A,0,R,1,G,2,B,3)] _BaseTexAlphaChannelSwitch ("BaseTexAlphaChannelSwitch", Float) = 0
[MHYToggle] _UseCustom2ColorToggle ("UseCustom2ColorToggle", Float) = 0
[Enum(RGB,0,R,1,G,2,B,3,A,4)] _BaseTexColorChannelSwitch ("BaseTexColorChannelSwitch", Float) = 0
_BaseTexAlphaBrightness ("BaseTexAlphaBrightness", Float) = 1
[MHYToggle] _BaseTexURandomToggle ("BaseTexURandomToggle", Float) = 0
[MHYToggle] _BaseTexVRandomToggle ("BaseTexVRandomToggle", Float) = 0
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 1
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 1
[Toggle(_NOISETEXTOGGLE_ON)] _NoiseTexToggle ("NoiseTex[Toggle]", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _NoiseTexChannelSwitch ("NoiseTexChannelSwitch", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 1
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 1
_ParticleCustomProp0 ("_ParticleCustomProp0", Vector) = (1,1,1,1)
_MeshParticleColorArray ("MeshParticleColorArray", Vector) = (1,1,1,1)
_Noise_Brightness ("Noise_Brightness", Float) = 1
_ParticleCustomProp1 ("_ParticleCustomProp1", Vector) = (1,1,1,1)
_Noise_Offset ("Noise_Offset", Float) = 0
[MHYToggle] _NoiseTexUVRandomToggle ("NoiseTexUVRandomToggle", Float) = 0
[Toggle(_MASKTEXTOGGLE_ON)] _MaskTexToggle ("MaskTex[Toggle]", Float) = 0
_NoiseIntensityOnMask ("NoiseIntensityOnMask", Float) = 0
[Enum(Multiply,0,Add,1)] _MaskTexBlendModeToggle ("MaskTexBlendModeToggle", Float) = 0
_MaskTex ("MaskTex", 2D) = "white" { }
[Enum(R,0,G,1,B,2,A,3)] _MaskTexChannelSwitch ("MaskTexChannelSwitch", Float) = 2
_MaskTex_Uspeed ("MaskTex_Uspeed", Float) = 0
_MaskTex_Vspeed ("MaskTex_Vspeed", Float) = 0
[MHYToggle] _MaskTexURandomToggle ("MaskTexURandomToggle", Float) = 0
[MHYToggle] _MaskTexVRandomToggle ("MaskTexVRandomToggle", Float) = 0
_MaskTexBrightness ("MaskTexBrightness", Float) = 1
[Toggle(_ALPHASOFTEDGETOGGLE_ON)] _AlphaSoftedgeToggle ("AlphaSoftedge[Toggle]", Float) = 0
_AlphaSoftedgeScale ("AlphaSoftedgeScale", Float) = 1
_AlphaSoftedgePower ("AlphaSoftedgePower", Float) = 1
[Toggle(_ALPHAFADEBYDISTANCETOGGLE_ON)] _AlphaFadeByDistanceToggle ("AlphaFadeByDistance[Toggle]", Float) = 0
_AlphaFadeDistance ("AlphaFadeDistance", Float) = 2
_AlphaFadeOffset ("AlphaFadeOffset", Float) = 0
[MHYToggle] _AlphaFadeDistanceInvertToggle ("AlphaFadeDistanceInvertToggle", Float) = 0
[Header(MiHoYoDepthFade)] [Toggle(_SOFTPARTICLES_ON)] _SOFTPARTICLES ("SOFTPARTICLES", Float) = 0
_DepthThresh ("DepthThresh", Range(0.001, 20)) = 1
_DepthFade ("DepthFade", Range(0.001, 20)) = 1
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
  GpuProgramID 16117
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat6;
float u_xlat9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6 = _Time.y * _BaseTex_Vspeed + u_xlat3.y;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat3.x;
    u_xlat9 = u_xlat6 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat9 : u_xlat6;
    u_xlat0.x = u_xlat3.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat4 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat4;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3.x = _DayColor.w * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10 = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat15 = u_xlat10 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat15 : u_xlat10;
    u_xlat0.x = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat6;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb10.x = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlat12 = u_xlat7 + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb15) ? u_xlat12 : u_xlat7;
    u_xlat15 = u_xlat2.x + vs_TEXCOORD1.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = (u_xlatb4.x) ? u_xlat15 : u_xlat2.x;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlat10 = u_xlatb10.x ? u_xlat2.w : float(0.0);
    u_xlat10 = (u_xlatb4.w) ? u_xlat2.z : u_xlat10;
    u_xlat10 = (u_xlatb4.z) ? u_xlat2.y : u_xlat10;
    u_xlat10 = (u_xlatb4.y) ? u_xlat2.x : u_xlat10;
    u_xlat10 = u_xlat10 * _MaskTexBrightness;
    u_xlat5.x = u_xlat10 * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat4.xy = u_xlat4.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4.x = u_xlatb4 ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat8 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat8;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat13 = u_xlatb2.y ? u_xlat1.w : float(0.0);
    u_xlat13 = (u_xlatb2.x) ? u_xlat1.z : u_xlat13;
    u_xlat13 = (u_xlatb3.w) ? u_xlat1.y : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat1.x : u_xlat13;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat13);
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat12;
int u_xlati13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat8 = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlat12 = u_xlat8 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat12 : u_xlat8;
    u_xlat0.x = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat5 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat5;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlati13 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati13]._MeshParticleColorArray;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat4.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat8;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat2.w * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb0 = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb5 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5 = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat5 = (u_xlatb3.z) ? u_xlat1.y : u_xlat5;
    u_xlat5 = (u_xlatb3.y) ? u_xlat1.x : u_xlat5;
    u_xlat5 = (u_xlatb3.x) ? u_xlat1.w : u_xlat5;
    u_xlat10.x = u_xlat5 * _BaseTexAlphaBrightness;
    u_xlat5 = u_xlat5 * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat5 = u_xlatb10.y ? u_xlat5 : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : u_xlat5;
    u_xlat5 = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5 = u_xlat5 * u_xlat3.w;
    u_xlat5 = u_xlat5 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
vec2 u_xlat5;
bool u_xlatb5;
float u_xlat6;
float u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb5 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat10 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5.x = u_xlat5.x * u_xlat2.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat6;
float u_xlat9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6 = _Time.y * _BaseTex_Vspeed + u_xlat3.y;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat3.x;
    u_xlat9 = u_xlat6 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat9 : u_xlat6;
    u_xlat0.x = u_xlat3.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat4 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat4;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3.x = _DayColor.w * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10 = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat15 = u_xlat10 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat15 : u_xlat10;
    u_xlat0.x = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat6;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb10.x = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlat12 = u_xlat7 + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb15) ? u_xlat12 : u_xlat7;
    u_xlat15 = u_xlat2.x + vs_TEXCOORD1.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = (u_xlatb4.x) ? u_xlat15 : u_xlat2.x;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlat10 = u_xlatb10.x ? u_xlat2.w : float(0.0);
    u_xlat10 = (u_xlatb4.w) ? u_xlat2.z : u_xlat10;
    u_xlat10 = (u_xlatb4.z) ? u_xlat2.y : u_xlat10;
    u_xlat10 = (u_xlatb4.y) ? u_xlat2.x : u_xlat10;
    u_xlat10 = u_xlat10 * _MaskTexBrightness;
    u_xlat5.x = u_xlat10 * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat4.xy = u_xlat4.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4.x = u_xlatb4 ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat8 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat8;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat13 = u_xlatb2.y ? u_xlat1.w : float(0.0);
    u_xlat13 = (u_xlatb2.x) ? u_xlat1.z : u_xlat13;
    u_xlat13 = (u_xlatb3.w) ? u_xlat1.y : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat1.x : u_xlat13;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat13);
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat12;
int u_xlati13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat8 = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlat12 = u_xlat8 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat12 : u_xlat8;
    u_xlat0.x = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat5 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat5;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlati13 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati13]._MeshParticleColorArray;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat4.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat8;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat2.w * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb0 = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb5 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5 = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat5 = (u_xlatb3.z) ? u_xlat1.y : u_xlat5;
    u_xlat5 = (u_xlatb3.y) ? u_xlat1.x : u_xlat5;
    u_xlat5 = (u_xlatb3.x) ? u_xlat1.w : u_xlat5;
    u_xlat10.x = u_xlat5 * _BaseTexAlphaBrightness;
    u_xlat5 = u_xlat5 * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat5 = u_xlatb10.y ? u_xlat5 : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : u_xlat5;
    u_xlat5 = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5 = u_xlat5 * u_xlat3.w;
    u_xlat5 = u_xlat5 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
vec2 u_xlat5;
bool u_xlatb5;
float u_xlat6;
float u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb5 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat10 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5.x = u_xlat5.x * u_xlat2.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat6 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb3 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb3) ? u_xlat6 : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3 = _DayColor.w * _AlphaBrightness;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat4 = (u_xlatb2.z) ? u_xlat0.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat4;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.x = _Time.y * _MaskTex_Uspeed + u_xlat8.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat13 : u_xlat8.x;
    u_xlat8.x = _Time.y * _MaskTex_Vspeed + u_xlat8.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb12) ? u_xlat13 : u_xlat8.x;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb8 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat8.x = u_xlatb8 ? u_xlat3.w : float(0.0);
    u_xlat8.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat4 : u_xlat0.x;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb9;
vec2 u_xlat10;
float u_xlat13;
bool u_xlatb13;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8 : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb0.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4 = u_xlat0.x * _Noise_Brightness;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb0.xzw = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle), vec4(3.0, 0.0, 4.0, 1.0)).xzw;
    u_xlat8 = u_xlatb0.z ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.z : u_xlat8;
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat0.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz + vs_TEXCOORD5.xyz;
    u_xlat0.xzw = (u_xlatb0.w) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb1.w ? u_xlat2.z : float(0.0);
    u_xlat9.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat13;
    u_xlat5 = (u_xlatb1.y) ? u_xlat2.x : u_xlat9.x;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat2.w : u_xlat5;
    u_xlat5 = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat9.x = _Time.y * _MaskTex_Uspeed + u_xlat9.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = u_xlat9.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat3.x : u_xlat9.x;
    u_xlat9.x = _Time.y * _MaskTex_Vspeed + u_xlat9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb13 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat9.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb13) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.xy = vec2(u_xlat4) * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat3.xy;
    u_xlat3 = texture(_MaskTex, u_xlat9.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4 = u_xlatb4 ? u_xlat3.w : float(0.0);
    u_xlat4 = (u_xlatb2.w) ? u_xlat3.z : u_xlat4;
    u_xlat4 = (u_xlatb2.z) ? u_xlat3.y : u_xlat4;
    u_xlat4 = (u_xlatb2.y) ? u_xlat3.x : u_xlat4;
    u_xlat4 = u_xlat4 * _MaskTexBrightness;
    u_xlat5 = u_xlat4 * u_xlat5;
    u_xlatb9.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4 = u_xlat1.x * _BaseTexAlphaBrightness + u_xlat4;
    u_xlat4 = u_xlatb9.y ? u_xlat4 : float(0.0);
    u_xlat4 = (u_xlatb9.x) ? u_xlat5 : u_xlat4;
    u_xlat1.x = _DayColor.w * _AlphaBrightness;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _MainColor.w;
    u_xlat1.w = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
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
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec3 u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8) ? u_xlat12 : u_xlat4.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat8 = u_xlatb4.y ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat2.z : u_xlat8;
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat4.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat4.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat4.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat1.w * u_xlat2.x;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bvec3 u_xlatb5;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat10;
bool u_xlatb10;
bvec2 u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat17;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10) ? u_xlat15 : u_xlat5.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb5.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat10 = u_xlatb5.y ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat10;
    u_xlat5.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat5.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat5.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat5.xyz = (u_xlatb5.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat2.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.x = _Time.y * _MaskTex_Uspeed + u_xlat7.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.x;
    u_xlat4.x = (u_xlatb3.x) ? u_xlat17 : u_xlat7.x;
    u_xlat7.x = _Time.y * _MaskTex_Vspeed + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.y;
    u_xlat4.y = (u_xlatb12.x) ? u_xlat17 : u_xlat7.x;
    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb7 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat7.x = u_xlatb7 ? u_xlat4.w : float(0.0);
    u_xlat7.x = (u_xlatb3.w) ? u_xlat4.z : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.z) ? u_xlat4.y : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.y) ? u_xlat4.x : u_xlat7.x;
    u_xlat7.x = u_xlat7.x * _MaskTexBrightness;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlatb12.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat7.x;
    u_xlat0.x = u_xlatb12.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb12.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat16 = u_xlat1.w * u_xlat2.x;
    u_xlat16 = u_xlat16 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat5.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
bvec4 u_xlatb4;
vec2 u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb12 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb12) ? u_xlat18 : u_xlat6.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat6.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat6.y;
    u_xlatb4 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat6.xy = (u_xlatb4.x) ? u_xlat6.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat6.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat3.w : float(0.0);
    u_xlat6.x = (u_xlatb4.w) ? u_xlat3.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.z) ? u_xlat3.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.y) ? u_xlat3.x : u_xlat6.x;
    u_xlat6.x = u_xlat6.x + _Noise_Offset;
    u_xlat12.x = u_xlat6.x * _Noise_Brightness;
    u_xlat6.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat6.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat6.xz);
    u_xlatb3.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb3.y ? u_xlat2.w : float(0.0);
    u_xlat6.x = (u_xlatb3.x) ? u_xlat2.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat6.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat6.xxx;
    u_xlat16_3.xyw = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb3.z) ? u_xlat3.xyw : u_xlat1.xyz;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb4.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat6.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat18 = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat19 = u_xlat18 + vs_TEXCOORD1.x;
    u_xlat5.x = (u_xlatb4.x) ? u_xlat19 : u_xlat18;
    u_xlat18 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb19 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat18 + vs_TEXCOORD1.y;
    u_xlat5.y = (u_xlatb19) ? u_xlat2.x : u_xlat18;
    u_xlat12.xy = u_xlat12.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat5.xy;
    u_xlat2 = texture(_MaskTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb12 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat12.x = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12.x = (u_xlatb4.w) ? u_xlat2.z : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat12.x;
    u_xlat12.x = u_xlat12.x * _MaskTexBrightness;
    u_xlat6.x = u_xlat12.x * u_xlat6.x;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat12.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat6.x = _DayColor.w * _AlphaBrightness;
    u_xlat6.x = u_xlat3.w * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat6 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb3 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb3) ? u_xlat6 : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3 = _DayColor.w * _AlphaBrightness;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat4 = (u_xlatb2.z) ? u_xlat0.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat4;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.x = _Time.y * _MaskTex_Uspeed + u_xlat8.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat13 : u_xlat8.x;
    u_xlat8.x = _Time.y * _MaskTex_Vspeed + u_xlat8.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb12) ? u_xlat13 : u_xlat8.x;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb8 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat8.x = u_xlatb8 ? u_xlat3.w : float(0.0);
    u_xlat8.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat4 : u_xlat0.x;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb9;
vec2 u_xlat10;
float u_xlat13;
bool u_xlatb13;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8 : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb0.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4 = u_xlat0.x * _Noise_Brightness;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb0.xzw = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle), vec4(3.0, 0.0, 4.0, 1.0)).xzw;
    u_xlat8 = u_xlatb0.z ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.z : u_xlat8;
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat0.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz + vs_TEXCOORD5.xyz;
    u_xlat0.xzw = (u_xlatb0.w) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb1.w ? u_xlat2.z : float(0.0);
    u_xlat9.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat13;
    u_xlat5 = (u_xlatb1.y) ? u_xlat2.x : u_xlat9.x;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat2.w : u_xlat5;
    u_xlat5 = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat9.x = _Time.y * _MaskTex_Uspeed + u_xlat9.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = u_xlat9.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat3.x : u_xlat9.x;
    u_xlat9.x = _Time.y * _MaskTex_Vspeed + u_xlat9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb13 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat9.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb13) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.xy = vec2(u_xlat4) * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat3.xy;
    u_xlat3 = texture(_MaskTex, u_xlat9.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4 = u_xlatb4 ? u_xlat3.w : float(0.0);
    u_xlat4 = (u_xlatb2.w) ? u_xlat3.z : u_xlat4;
    u_xlat4 = (u_xlatb2.z) ? u_xlat3.y : u_xlat4;
    u_xlat4 = (u_xlatb2.y) ? u_xlat3.x : u_xlat4;
    u_xlat4 = u_xlat4 * _MaskTexBrightness;
    u_xlat5 = u_xlat4 * u_xlat5;
    u_xlatb9.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4 = u_xlat1.x * _BaseTexAlphaBrightness + u_xlat4;
    u_xlat4 = u_xlatb9.y ? u_xlat4 : float(0.0);
    u_xlat4 = (u_xlatb9.x) ? u_xlat5 : u_xlat4;
    u_xlat1.x = _DayColor.w * _AlphaBrightness;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _MainColor.w;
    u_xlat1.w = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec3 u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8) ? u_xlat12 : u_xlat4.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat8 = u_xlatb4.y ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat2.z : u_xlat8;
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat4.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat4.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat4.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat1.w * u_xlat2.x;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bvec3 u_xlatb5;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat10;
bool u_xlatb10;
bvec2 u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat17;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10) ? u_xlat15 : u_xlat5.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb5.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat10 = u_xlatb5.y ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat10;
    u_xlat5.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat5.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat5.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat5.xyz = (u_xlatb5.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat2.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.x = _Time.y * _MaskTex_Uspeed + u_xlat7.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.x;
    u_xlat4.x = (u_xlatb3.x) ? u_xlat17 : u_xlat7.x;
    u_xlat7.x = _Time.y * _MaskTex_Vspeed + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.y;
    u_xlat4.y = (u_xlatb12.x) ? u_xlat17 : u_xlat7.x;
    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb7 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat7.x = u_xlatb7 ? u_xlat4.w : float(0.0);
    u_xlat7.x = (u_xlatb3.w) ? u_xlat4.z : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.z) ? u_xlat4.y : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.y) ? u_xlat4.x : u_xlat7.x;
    u_xlat7.x = u_xlat7.x * _MaskTexBrightness;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlatb12.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat7.x;
    u_xlat0.x = u_xlatb12.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb12.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat16 = u_xlat1.w * u_xlat2.x;
    u_xlat16 = u_xlat16 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat5.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
bvec4 u_xlatb4;
vec2 u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb12 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb12) ? u_xlat18 : u_xlat6.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat6.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat6.y;
    u_xlatb4 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat6.xy = (u_xlatb4.x) ? u_xlat6.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat6.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat3.w : float(0.0);
    u_xlat6.x = (u_xlatb4.w) ? u_xlat3.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.z) ? u_xlat3.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.y) ? u_xlat3.x : u_xlat6.x;
    u_xlat6.x = u_xlat6.x + _Noise_Offset;
    u_xlat12.x = u_xlat6.x * _Noise_Brightness;
    u_xlat6.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat6.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat6.xz);
    u_xlatb3.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb3.y ? u_xlat2.w : float(0.0);
    u_xlat6.x = (u_xlatb3.x) ? u_xlat2.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat6.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat6.xxx;
    u_xlat16_3.xyw = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb3.z) ? u_xlat3.xyw : u_xlat1.xyz;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb4.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat6.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat18 = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat19 = u_xlat18 + vs_TEXCOORD1.x;
    u_xlat5.x = (u_xlatb4.x) ? u_xlat19 : u_xlat18;
    u_xlat18 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb19 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat18 + vs_TEXCOORD1.y;
    u_xlat5.y = (u_xlatb19) ? u_xlat2.x : u_xlat18;
    u_xlat12.xy = u_xlat12.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat5.xy;
    u_xlat2 = texture(_MaskTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb12 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat12.x = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12.x = (u_xlatb4.w) ? u_xlat2.z : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat12.x;
    u_xlat12.x = u_xlat12.x * _MaskTexBrightness;
    u_xlat6.x = u_xlat12.x * u_xlat6.x;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat12.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat6.x = _DayColor.w * _AlphaBrightness;
    u_xlat6.x = u_xlat3.w * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat6;
float u_xlat9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6 = _Time.y * _BaseTex_Vspeed + u_xlat3.y;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat3.x;
    u_xlat9 = u_xlat6 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat9 : u_xlat6;
    u_xlat0.x = u_xlat3.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat4 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat4;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3.x = _DayColor.w * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10 = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat15 = u_xlat10 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat15 : u_xlat10;
    u_xlat0.x = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat6;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb10.x = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlat12 = u_xlat7 + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb15) ? u_xlat12 : u_xlat7;
    u_xlat15 = u_xlat2.x + vs_TEXCOORD1.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = (u_xlatb4.x) ? u_xlat15 : u_xlat2.x;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlat10 = u_xlatb10.x ? u_xlat2.w : float(0.0);
    u_xlat10 = (u_xlatb4.w) ? u_xlat2.z : u_xlat10;
    u_xlat10 = (u_xlatb4.z) ? u_xlat2.y : u_xlat10;
    u_xlat10 = (u_xlatb4.y) ? u_xlat2.x : u_xlat10;
    u_xlat10 = u_xlat10 * _MaskTexBrightness;
    u_xlat5.x = u_xlat10 * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat4.xy = u_xlat4.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4.x = u_xlatb4 ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat8 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat8;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat13 = u_xlatb2.y ? u_xlat1.w : float(0.0);
    u_xlat13 = (u_xlatb2.x) ? u_xlat1.z : u_xlat13;
    u_xlat13 = (u_xlatb3.w) ? u_xlat1.y : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat1.x : u_xlat13;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat13);
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat12;
int u_xlati13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat8 = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlat12 = u_xlat8 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat12 : u_xlat8;
    u_xlat0.x = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat5 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat5;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlati13 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati13]._MeshParticleColorArray;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat4.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat8;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat2.w * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb0 = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb5 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5 = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat5 = (u_xlatb3.z) ? u_xlat1.y : u_xlat5;
    u_xlat5 = (u_xlatb3.y) ? u_xlat1.x : u_xlat5;
    u_xlat5 = (u_xlatb3.x) ? u_xlat1.w : u_xlat5;
    u_xlat10.x = u_xlat5 * _BaseTexAlphaBrightness;
    u_xlat5 = u_xlat5 * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat5 = u_xlatb10.y ? u_xlat5 : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : u_xlat5;
    u_xlat5 = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5 = u_xlat5 * u_xlat3.w;
    u_xlat5 = u_xlat5 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
vec2 u_xlat5;
bool u_xlatb5;
float u_xlat6;
float u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb5 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat10 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5.x = u_xlat5.x * u_xlat2.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
float u_xlat4;
float u_xlat6;
float u_xlat9;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat3.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6 = _Time.y * _BaseTex_Vspeed + u_xlat3.y;
    u_xlat3.x = _Time.y * _BaseTex_Uspeed + u_xlat3.x;
    u_xlat9 = u_xlat6 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat9 : u_xlat6;
    u_xlat0.x = u_xlat3.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat3.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat4 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat4;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3.x = _DayColor.w * _AlphaBrightness;
    u_xlat3.x = u_xlat3.x * vs_COLOR0.w;
    u_xlat3.x = u_xlat3.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec2 u_xlat3;
bvec4 u_xlatb4;
vec2 u_xlat5;
float u_xlat6;
float u_xlat7;
float u_xlat10;
bvec2 u_xlatb10;
float u_xlat12;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat10 = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlat15 = u_xlat10 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat15 : u_xlat10;
    u_xlat0.x = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat5.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat6;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat10 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat0.y : u_xlat10;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat5.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat5.x = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb10.x = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
    u_xlat2.x = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlat12 = u_xlat7 + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb15) ? u_xlat12 : u_xlat7;
    u_xlat15 = u_xlat2.x + vs_TEXCOORD1.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = (u_xlatb4.x) ? u_xlat15 : u_xlat2.x;
    u_xlat2 = texture(_MaskTex, u_xlat3.xy);
    u_xlat10 = u_xlatb10.x ? u_xlat2.w : float(0.0);
    u_xlat10 = (u_xlatb4.w) ? u_xlat2.z : u_xlat10;
    u_xlat10 = (u_xlatb4.z) ? u_xlat2.y : u_xlat10;
    u_xlat10 = (u_xlatb4.y) ? u_xlat2.x : u_xlat10;
    u_xlat10 = u_xlat10 * _MaskTexBrightness;
    u_xlat5.x = u_xlat10 * u_xlat5.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
bvec2 u_xlatb8;
float u_xlat12;
float u_xlat13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat4.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat4.y;
    u_xlat4.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat4.xy = (u_xlatb2.x) ? u_xlat4.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat4.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat4.xy = u_xlat4.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4.x = u_xlatb4 ? u_xlat1.w : float(0.0);
    u_xlat4.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat8 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat8 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat8;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4.x : u_xlat0.x;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat4.x * vs_COLOR0.w;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat13 = u_xlatb2.y ? u_xlat1.w : float(0.0);
    u_xlat13 = (u_xlatb2.x) ? u_xlat1.z : u_xlat13;
    u_xlat13 = (u_xlatb3.w) ? u_xlat1.y : u_xlat13;
    u_xlat13 = (u_xlatb3.z) ? u_xlat1.x : u_xlat13;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat13);
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
bvec3 u_xlatb1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat8;
float u_xlat12;
int u_xlati13;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb0 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat8 = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlat12 = u_xlat8 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb0) ? u_xlat12 : u_xlat8;
    u_xlat0.x = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.x : u_xlat4.x;
    u_xlat0 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb1.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat5 = u_xlatb1.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb1.x) ? u_xlat0.z : u_xlat5;
    u_xlat1.x = (u_xlatb2.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb2.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyw = (u_xlatb2.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb1.z) ? u_xlat2.xyz : u_xlat1.xyw;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlati13 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati13]._MeshParticleColorArray;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _DayColor.xyz;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8 = u_xlatb3.w ? u_xlat0.z : float(0.0);
    u_xlat4.x = (u_xlatb3.z) ? u_xlat0.y : u_xlat8;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat0.x : u_xlat4.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4.x = _DayColor.w * _AlphaBrightness;
    u_xlat4.x = u_xlat2.w * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * _MainColor.w;
    u_xlat1.w = u_xlat0.x * u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
bvec4 u_xlatb2;
vec4 u_xlat3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
float u_xlat5;
bool u_xlatb5;
vec2 u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb0 = _MaskTexChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb5 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _MaskTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb5 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat10.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat10.y;
    u_xlat10.x = _Time.y * _BaseTex_Uspeed + u_xlat10.x;
    u_xlat1.x = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb5) ? u_xlat1.x : u_xlat15;
    u_xlat5 = u_xlat10.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat5 : u_xlat10.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5 = u_xlatb3.w ? u_xlat1.z : float(0.0);
    u_xlat5 = (u_xlatb3.z) ? u_xlat1.y : u_xlat5;
    u_xlat5 = (u_xlatb3.y) ? u_xlat1.x : u_xlat5;
    u_xlat5 = (u_xlatb3.x) ? u_xlat1.w : u_xlat5;
    u_xlat10.x = u_xlat5 * _BaseTexAlphaBrightness;
    u_xlat5 = u_xlat5 * _BaseTexAlphaBrightness + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat5 = u_xlatb10.y ? u_xlat5 : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : u_xlat5;
    u_xlat5 = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5 = u_xlat5 * u_xlat3.w;
    u_xlat5 = u_xlat5 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb2.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb2.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb2.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_2.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat2.xyz = u_xlat1.xxx * u_xlat16_2.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat2.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
bvec3 u_xlatb4;
vec2 u_xlat5;
bool u_xlatb5;
float u_xlat6;
float u_xlat10;
int u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb5 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat5.x = u_xlatb5 ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb3.w) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.z) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb3.y) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10 = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10 : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb2.w ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat1.w : u_xlat0.x;
    u_xlat10 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlati10 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat2 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati10]._MeshParticleColorArray;
    u_xlat5.x = u_xlat5.x * u_xlat2.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat16 = u_xlatb4.y ? u_xlat1.w : float(0.0);
    u_xlat16 = (u_xlatb4.x) ? u_xlat1.z : u_xlat16;
    u_xlat16 = (u_xlatb3.w) ? u_xlat1.y : u_xlat16;
    u_xlat16 = (u_xlatb3.z) ? u_xlat1.x : u_xlat16;
    u_xlat1.xyz = (u_xlatb3.y) ? u_xlat1.xyz : vec3(u_xlat16);
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat6 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb3 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb3) ? u_xlat6 : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3 = _DayColor.w * _AlphaBrightness;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat4 = (u_xlatb2.z) ? u_xlat0.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat4;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.x = _Time.y * _MaskTex_Uspeed + u_xlat8.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat13 : u_xlat8.x;
    u_xlat8.x = _Time.y * _MaskTex_Vspeed + u_xlat8.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb12) ? u_xlat13 : u_xlat8.x;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb8 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat8.x = u_xlatb8 ? u_xlat3.w : float(0.0);
    u_xlat8.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat4 : u_xlat0.x;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb9;
vec2 u_xlat10;
float u_xlat13;
bool u_xlatb13;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8 : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb0.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4 = u_xlat0.x * _Noise_Brightness;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb0.xzw = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle), vec4(3.0, 0.0, 4.0, 1.0)).xzw;
    u_xlat8 = u_xlatb0.z ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.z : u_xlat8;
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat0.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz + vs_TEXCOORD5.xyz;
    u_xlat0.xzw = (u_xlatb0.w) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb1.w ? u_xlat2.z : float(0.0);
    u_xlat9.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat13;
    u_xlat5 = (u_xlatb1.y) ? u_xlat2.x : u_xlat9.x;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat2.w : u_xlat5;
    u_xlat5 = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat9.x = _Time.y * _MaskTex_Uspeed + u_xlat9.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = u_xlat9.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat3.x : u_xlat9.x;
    u_xlat9.x = _Time.y * _MaskTex_Vspeed + u_xlat9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb13 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat9.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb13) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.xy = vec2(u_xlat4) * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat3.xy;
    u_xlat3 = texture(_MaskTex, u_xlat9.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4 = u_xlatb4 ? u_xlat3.w : float(0.0);
    u_xlat4 = (u_xlatb2.w) ? u_xlat3.z : u_xlat4;
    u_xlat4 = (u_xlatb2.z) ? u_xlat3.y : u_xlat4;
    u_xlat4 = (u_xlatb2.y) ? u_xlat3.x : u_xlat4;
    u_xlat4 = u_xlat4 * _MaskTexBrightness;
    u_xlat5 = u_xlat4 * u_xlat5;
    u_xlatb9.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4 = u_xlat1.x * _BaseTexAlphaBrightness + u_xlat4;
    u_xlat4 = u_xlatb9.y ? u_xlat4 : float(0.0);
    u_xlat4 = (u_xlatb9.x) ? u_xlat5 : u_xlat4;
    u_xlat1.x = _DayColor.w * _AlphaBrightness;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _MainColor.w;
    u_xlat1.w = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
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
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec3 u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8) ? u_xlat12 : u_xlat4.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat8 = u_xlatb4.y ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat2.z : u_xlat8;
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat4.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat4.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat4.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat1.w * u_xlat2.x;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bvec3 u_xlatb5;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat10;
bool u_xlatb10;
bvec2 u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat17;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10) ? u_xlat15 : u_xlat5.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb5.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat10 = u_xlatb5.y ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat10;
    u_xlat5.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat5.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat5.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat5.xyz = (u_xlatb5.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat2.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.x = _Time.y * _MaskTex_Uspeed + u_xlat7.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.x;
    u_xlat4.x = (u_xlatb3.x) ? u_xlat17 : u_xlat7.x;
    u_xlat7.x = _Time.y * _MaskTex_Vspeed + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.y;
    u_xlat4.y = (u_xlatb12.x) ? u_xlat17 : u_xlat7.x;
    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb7 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat7.x = u_xlatb7 ? u_xlat4.w : float(0.0);
    u_xlat7.x = (u_xlatb3.w) ? u_xlat4.z : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.z) ? u_xlat4.y : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.y) ? u_xlat4.x : u_xlat7.x;
    u_xlat7.x = u_xlat7.x * _MaskTexBrightness;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlatb12.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat7.x;
    u_xlat0.x = u_xlatb12.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb12.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat16 = u_xlat1.w * u_xlat2.x;
    u_xlat16 = u_xlat16 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat5.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
bvec4 u_xlatb4;
vec2 u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb12 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb12) ? u_xlat18 : u_xlat6.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat6.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat6.y;
    u_xlatb4 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat6.xy = (u_xlatb4.x) ? u_xlat6.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat6.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat3.w : float(0.0);
    u_xlat6.x = (u_xlatb4.w) ? u_xlat3.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.z) ? u_xlat3.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.y) ? u_xlat3.x : u_xlat6.x;
    u_xlat6.x = u_xlat6.x + _Noise_Offset;
    u_xlat12.x = u_xlat6.x * _Noise_Brightness;
    u_xlat6.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat6.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat6.xz);
    u_xlatb3.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb3.y ? u_xlat2.w : float(0.0);
    u_xlat6.x = (u_xlatb3.x) ? u_xlat2.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat6.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat6.xxx;
    u_xlat16_3.xyw = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb3.z) ? u_xlat3.xyw : u_xlat1.xyz;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb4.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat6.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat18 = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat19 = u_xlat18 + vs_TEXCOORD1.x;
    u_xlat5.x = (u_xlatb4.x) ? u_xlat19 : u_xlat18;
    u_xlat18 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb19 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat18 + vs_TEXCOORD1.y;
    u_xlat5.y = (u_xlatb19) ? u_xlat2.x : u_xlat18;
    u_xlat12.xy = u_xlat12.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat5.xy;
    u_xlat2 = texture(_MaskTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb12 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat12.x = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12.x = (u_xlatb4.w) ? u_xlat2.z : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat12.x;
    u_xlat12.x = u_xlat12.x * _MaskTexBrightness;
    u_xlat6.x = u_xlat12.x * u_xlat6.x;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat12.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat6.x = _DayColor.w * _AlphaBrightness;
    u_xlat6.x = u_xlat3.w * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
float u_xlat3;
bool u_xlatb3;
float u_xlat6;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat6 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb3 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat6 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb3) ? u_xlat6 : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat6 = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat3 = (u_xlatb2.z) ? u_xlat0.y : u_xlat6;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat3;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat3 = _DayColor.w * _AlphaBrightness;
    u_xlat3 = u_xlat3 * vs_COLOR0.w;
    u_xlat3 = u_xlat3 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
bool u_xlatb8;
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
    u_xlat0.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8.x : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.x = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8.x : u_xlat0.x;
    u_xlat0 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb2.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat1.x = u_xlatb2.y ? u_xlat0.w : float(0.0);
    u_xlat1.x = (u_xlatb2.x) ? u_xlat0.z : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.w) ? u_xlat0.y : u_xlat1.x;
    u_xlat1.x = (u_xlatb1.z) ? u_xlat0.x : u_xlat1.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat0.xyz : u_xlat1.xxx;
    u_xlat2.xyw = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat2.xyw = u_xlat1.xxx * u_xlat2.xyw + vs_TEXCOORD5.xyz;
    u_xlat1.xyz = (u_xlatb2.z) ? u_xlat2.xyw : u_xlat1.xyz;
    u_xlatb2 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat0.z : float(0.0);
    u_xlat4 = (u_xlatb2.z) ? u_xlat0.y : u_xlat8.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat0.x : u_xlat4;
    u_xlat0.x = (u_xlatb2.x) ? u_xlat0.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat8.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat8.x = _Time.y * _MaskTex_Uspeed + u_xlat8.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat13 : u_xlat8.x;
    u_xlat8.x = _Time.y * _MaskTex_Vspeed + u_xlat8.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat13 = u_xlat8.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb12) ? u_xlat13 : u_xlat8.x;
    u_xlat3 = texture(_MaskTex, u_xlat3.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb8 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat8.x = u_xlatb8 ? u_xlat3.w : float(0.0);
    u_xlat8.x = (u_xlatb2.w) ? u_xlat3.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.z) ? u_xlat3.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat3.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat4 : u_xlat0.x;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position.z = _MHYZBias * u_xlat1.w + u_xlat1.z;
    gl_Position.xyw = u_xlat1.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD6.w = (-u_xlat0.x);
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD6.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD7.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat1.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec4 u_xlatb2;
vec4 u_xlat3;
float u_xlat4;
bool u_xlatb4;
float u_xlat5;
float u_xlat8;
vec2 u_xlat9;
bvec2 u_xlatb9;
vec2 u_xlat10;
float u_xlat13;
bool u_xlatb13;
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
    u_xlat0.x = _Time.y * _BaseTex_Uspeed + u_xlat0.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat8 : u_xlat0.x;
    u_xlat0.x = _Time.y * _BaseTex_Vspeed + u_xlat0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8 = u_xlat0.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb4) ? u_xlat8 : u_xlat0.x;
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat0.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat0.y;
    u_xlatb0 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat10.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat10.xy = (u_xlatb0.x) ? u_xlat10.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat10.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0.x = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0.x ? u_xlat3.w : float(0.0);
    u_xlat0.x = (u_xlatb0.w) ? u_xlat3.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.z) ? u_xlat3.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb0.y) ? u_xlat3.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat4 = u_xlat0.x * _Noise_Brightness;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat0.xz);
    u_xlatb0.xzw = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle), vec4(3.0, 0.0, 4.0, 1.0)).xzw;
    u_xlat8 = u_xlatb0.z ? u_xlat2.w : float(0.0);
    u_xlat0.x = (u_xlatb0.x) ? u_xlat2.z : u_xlat8;
    u_xlat0.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat0.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat0.xxx;
    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-vs_TEXCOORD5.xyz);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz + vs_TEXCOORD5.xyz;
    u_xlat0.xzw = (u_xlatb0.w) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlatb1 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat13 = u_xlatb1.w ? u_xlat2.z : float(0.0);
    u_xlat9.x = (u_xlatb1.z) ? u_xlat2.y : u_xlat13;
    u_xlat5 = (u_xlatb1.y) ? u_xlat2.x : u_xlat9.x;
    u_xlat1.x = (u_xlatb1.x) ? u_xlat2.w : u_xlat5;
    u_xlat5 = u_xlat1.x * _BaseTexAlphaBrightness;
    u_xlat9.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat9.x = _Time.y * _MaskTex_Uspeed + u_xlat9.x;
    u_xlatb2 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat3.x = u_xlat9.x + vs_TEXCOORD1.x;
    u_xlat3.x = (u_xlatb2.x) ? u_xlat3.x : u_xlat9.x;
    u_xlat9.x = _Time.y * _MaskTex_Vspeed + u_xlat9.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb13 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat9.x + vs_TEXCOORD1.y;
    u_xlat3.y = (u_xlatb13) ? u_xlat2.x : u_xlat9.x;
    u_xlat9.xy = vec2(u_xlat4) * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat3.xy;
    u_xlat3 = texture(_MaskTex, u_xlat9.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb4 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat4 = u_xlatb4 ? u_xlat3.w : float(0.0);
    u_xlat4 = (u_xlatb2.w) ? u_xlat3.z : u_xlat4;
    u_xlat4 = (u_xlatb2.z) ? u_xlat3.y : u_xlat4;
    u_xlat4 = (u_xlatb2.y) ? u_xlat3.x : u_xlat4;
    u_xlat4 = u_xlat4 * _MaskTexBrightness;
    u_xlat5 = u_xlat4 * u_xlat5;
    u_xlatb9.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat4 = u_xlat1.x * _BaseTexAlphaBrightness + u_xlat4;
    u_xlat4 = u_xlatb9.y ? u_xlat4 : float(0.0);
    u_xlat4 = (u_xlatb9.x) ? u_xlat5 : u_xlat4;
    u_xlat1.x = _DayColor.w * _AlphaBrightness;
    u_xlat1.x = u_xlat1.x * vs_COLOR0.w;
    u_xlat1.x = u_xlat1.x * _MainColor.w;
    u_xlat1.w = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xzw * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * _DayColor.xyz;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec3 u_xlat4;
bvec3 u_xlatb4;
float u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat4.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat4.x = _Time.y * _BaseTex_Uspeed + u_xlat4.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat12 : u_xlat4.x;
    u_xlat4.x = _Time.y * _BaseTex_Vspeed + u_xlat4.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb8 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat12 = u_xlat4.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb8) ? u_xlat12 : u_xlat4.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb4.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat8 = u_xlatb4.y ? u_xlat2.w : float(0.0);
    u_xlat4.x = (u_xlatb4.x) ? u_xlat2.z : u_xlat8;
    u_xlat4.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat4.x;
    u_xlat4.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat4.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat4.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat4.xyz = (u_xlatb4.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat13 = u_xlat1.w * u_xlat2.x;
    u_xlat13 = u_xlat13 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bvec4 u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bvec3 u_xlatb5;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat10;
bool u_xlatb10;
bvec2 u_xlatb12;
float u_xlat15;
float u_xlat16;
float u_xlat17;
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
    u_xlat5.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat5.x = _Time.y * _BaseTex_Uspeed + u_xlat5.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = _Time.y * _BaseTex_Vspeed + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat15 = u_xlat5.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10) ? u_xlat15 : u_xlat5.x;
    u_xlat2 = texture(_BaseTex, u_xlat2.xy);
    u_xlatb5.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _UseCustom2ColorToggle), vec4(3.0, 4.0, 1.0, 1.0)).xyz;
    u_xlat10 = u_xlatb5.y ? u_xlat2.w : float(0.0);
    u_xlat5.x = (u_xlatb5.x) ? u_xlat2.z : u_xlat10;
    u_xlat5.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat5.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat5.xxx;
    u_xlat16_3.xyz = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat16_3.xyz + _ParticleCustomProp0.xyz;
    u_xlat5.xyz = (u_xlatb5.z) ? u_xlat3.xyz : u_xlat1.xyz;
    u_xlat1 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb3 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb3.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb3.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat2.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat7.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat7.x = _Time.y * _MaskTex_Uspeed + u_xlat7.x;
    u_xlatb3 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.x;
    u_xlat4.x = (u_xlatb3.x) ? u_xlat17 : u_xlat7.x;
    u_xlat7.x = _Time.y * _MaskTex_Vspeed + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12.x = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12.x = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat17 = u_xlat7.x + vs_TEXCOORD1.y;
    u_xlat4.y = (u_xlatb12.x) ? u_xlat17 : u_xlat7.x;
    u_xlat4 = texture(_MaskTex, u_xlat4.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb7 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat7.x = u_xlatb7 ? u_xlat4.w : float(0.0);
    u_xlat7.x = (u_xlatb3.w) ? u_xlat4.z : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.z) ? u_xlat4.y : u_xlat7.x;
    u_xlat7.x = (u_xlatb3.y) ? u_xlat4.x : u_xlat7.x;
    u_xlat7.x = u_xlat7.x * _MaskTexBrightness;
    u_xlat2.x = u_xlat7.x * u_xlat2.x;
    u_xlatb12.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat7.x;
    u_xlat0.x = u_xlatb12.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb12.x) ? u_xlat2.x : u_xlat0.x;
    u_xlat2.x = _DayColor.w * _AlphaBrightness;
    u_xlat16 = u_xlat1.w * u_xlat2.x;
    u_xlat16 = u_xlat16 * _MainColor.w;
    u_xlat2.w = u_xlat0.x * u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat5.xyz * vec3(_ColorBrightness);
    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _DayColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec4 in_TEXCOORD3;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD8;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
vec3 u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position.z = _MHYZBias * u_xlat2.w + u_xlat2.z;
    gl_Position.xyw = u_xlat2.xyw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    vs_TEXCOORD5 = in_TEXCOORD3;
    u_xlat4.xyz = in_POSITION0.yyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3 = inversesqrt(u_xlat3);
    vs_TEXCOORD6.xyz = u_xlat4.xyz * vec3(u_xlat3);
    u_xlat4.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat4.x;
    vs_TEXCOORD6.w = (-u_xlat4.x);
    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD7.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD7.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD8.zw = u_xlat2.zw;
    vs_TEXCOORD8.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _ColorBrightness;
uniform 	mediump float _UseCustom2ColorToggle;
uniform 	mediump float _BaseTexColorChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump vec4 _ParticleCustomProp0;
uniform 	mediump vec4 _ParticleCustomProp1;
uniform 	vec4 _MainColor;
uniform 	vec4 _DayColor;
uniform 	float _AlphaBrightness;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoParticlesUVmove_TwoColorArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoParticlesUVmove_TwoColor {
	miHoYoParticlesUVmove_TwoColorArray_Type miHoYoParticlesUVmove_TwoColorArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
int u_xlati0;
bvec2 u_xlatb0;
vec3 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
bvec3 u_xlatb3;
bvec4 u_xlatb4;
vec2 u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat18;
float u_xlat19;
bool u_xlatb19;
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
    u_xlat6.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat6.x = _Time.y * _BaseTex_Uspeed + u_xlat6.x;
    u_xlatb1 = equal(vec4(_BaseTexURandomToggle, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb1.x) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = _Time.y * _BaseTex_Vspeed + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb12 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat18 = u_xlat6.x + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb12) ? u_xlat18 : u_xlat6.x;
    u_xlat6.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat3.x = _Time.y * _NoiseTex_Uspeed + u_xlat6.x;
    u_xlat3.y = _Time.y * _NoiseTex_Vspeed + u_xlat6.y;
    u_xlatb4 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat6.xy = u_xlat3.xy + vs_TEXCOORD1.xy;
    u_xlat6.xy = (u_xlatb4.x) ? u_xlat6.xy : u_xlat3.xy;
    u_xlat3 = texture(_NoiseTex, u_xlat6.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb6 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat6.x = u_xlatb6 ? u_xlat3.w : float(0.0);
    u_xlat6.x = (u_xlatb4.w) ? u_xlat3.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.z) ? u_xlat3.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb4.y) ? u_xlat3.x : u_xlat6.x;
    u_xlat6.x = u_xlat6.x + _Noise_Offset;
    u_xlat12.x = u_xlat6.x * _Noise_Brightness;
    u_xlat6.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat6.xx + u_xlat2.xy;
    u_xlat2 = texture(_BaseTex, u_xlat6.xz);
    u_xlatb3.xyz = equal(vec4(_BaseTexColorChannelSwitch, _BaseTexColorChannelSwitch, _UseCustom2ColorToggle, _BaseTexColorChannelSwitch), vec4(3.0, 4.0, 1.0, 0.0)).xyz;
    u_xlat6.x = u_xlatb3.y ? u_xlat2.w : float(0.0);
    u_xlat6.x = (u_xlatb3.x) ? u_xlat2.z : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.w) ? u_xlat2.y : u_xlat6.x;
    u_xlat6.x = (u_xlatb1.z) ? u_xlat2.x : u_xlat6.x;
    u_xlat1.xyz = (u_xlatb1.y) ? u_xlat2.xyz : u_xlat6.xxx;
    u_xlat16_3.xyw = (-_ParticleCustomProp0.xyz) + _ParticleCustomProp1.xyz;
    u_xlat3.xyw = u_xlat1.xxx * u_xlat16_3.xyw + _ParticleCustomProp0.xyz;
    u_xlat1.xyz = (u_xlatb3.z) ? u_xlat3.xyw : u_xlat1.xyz;
    u_xlat3 = vs_COLOR0 * miHoYoParticlesUVmove_TwoColorArray[u_xlati0]._MeshParticleColorArray;
    u_xlatb4 = equal(vec4(_BaseTexAlphaChannelSwitch), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat0.x = u_xlatb4.w ? u_xlat2.z : float(0.0);
    u_xlat0.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb4.x) ? u_xlat2.w : u_xlat0.x;
    u_xlat6.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat18 = _Time.y * _MaskTex_Uspeed + u_xlat2.x;
    u_xlatb4 = equal(vec4(_MaskTexURandomToggle, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat19 = u_xlat18 + vs_TEXCOORD1.x;
    u_xlat5.x = (u_xlatb4.x) ? u_xlat19 : u_xlat18;
    u_xlat18 = _Time.y * _MaskTex_Vspeed + u_xlat2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb19 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.x = u_xlat18 + vs_TEXCOORD1.y;
    u_xlat5.y = (u_xlatb19) ? u_xlat2.x : u_xlat18;
    u_xlat12.xy = u_xlat12.xx * vec2(vec2(_NoiseIntensityOnMask, _NoiseIntensityOnMask)) + u_xlat5.xy;
    u_xlat2 = texture(_MaskTex, u_xlat12.xy);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexChannelSwitch==3.0);
#else
    u_xlatb12 = _MaskTexChannelSwitch==3.0;
#endif
    u_xlat12.x = u_xlatb12 ? u_xlat2.w : float(0.0);
    u_xlat12.x = (u_xlatb4.w) ? u_xlat2.z : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.z) ? u_xlat2.y : u_xlat12.x;
    u_xlat12.x = (u_xlatb4.y) ? u_xlat2.x : u_xlat12.x;
    u_xlat12.x = u_xlat12.x * _MaskTexBrightness;
    u_xlat6.x = u_xlat12.x * u_xlat6.x;
    u_xlatb2.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 0.0)).xy;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat12.x;
    u_xlat0.x = u_xlatb2.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb2.x) ? u_xlat6.x : u_xlat0.x;
    u_xlat6.x = _DayColor.w * _AlphaBrightness;
    u_xlat6.x = u_xlat3.w * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * _MainColor.w;
    u_xlat0.w = u_xlat0.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
#else
    u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xyz * vec3(_ColorBrightness);
    u_xlat1.xyz = u_xlat3.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat1.xyz * _DayColor.xyz;
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
Keywords { "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_HEIGHT" "UNITY_DEBUG_VIEW_ON" "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
}
}
 Pass {
  Name "DISTORTIONVECTORS"
  Tags { "AllowDistortionVectors" = "False" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DISTORTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 83681
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
  GpuProgramID 133473
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat8;
ivec2 u_xlati8;
bvec2 u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb12) ? u_xlat8.x : u_xlat1.x;
    u_xlat1 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4 : u_xlat0.x;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
vec2 u_xlat10;
ivec2 u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb15) ? u_xlat10.x : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(_NoiseIntensityOnMask) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10.x : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat10.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati1.xy;
    u_xlat10.xy = vec2(u_xlati10.xy);
    u_xlat0.xy = u_xlat10.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat3.xxx;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
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
float u_xlat4;
int u_xlati4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4 = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat8.x = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat3.xxx;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat8;
ivec2 u_xlati8;
bvec2 u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb12) ? u_xlat8.x : u_xlat1.x;
    u_xlat1 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4 : u_xlat0.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4 = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat8.x = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat3.xxx;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
int u_xlati5;
float u_xlat6;
vec2 u_xlat10;
ivec2 u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb15) ? u_xlat10.x : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(_NoiseIntensityOnMask) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10.x : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat10.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati5]._MeshParticleColorArray.w;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati1.xy;
    u_xlat10.xy = vec2(u_xlati10.xy);
    u_xlat0.xy = u_xlat10.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat8;
ivec2 u_xlati8;
bvec2 u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb12) ? u_xlat8.x : u_xlat1.x;
    u_xlat1 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4 : u_xlat0.x;
    u_xlat4 = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * vs_COLOR0.w;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
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
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD5.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
float u_xlat6;
vec2 u_xlat10;
ivec2 u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb15) ? u_xlat10.x : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(_NoiseIntensityOnMask) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10.x : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat10.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlat5.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * vs_COLOR0.w;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati1.xy;
    u_xlat10.xy = vec2(u_xlati10.xy);
    u_xlat0.xy = u_xlat10.xy * u_xlat0.xy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat3.xxx;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
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
float u_xlat4;
int u_xlati4;
bool u_xlatb4;
vec2 u_xlat8;
ivec2 u_xlati8;
float u_xlat12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4 = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat8.x = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat3.xxx;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
int u_xlati4;
bool u_xlatb4;
float u_xlat5;
vec2 u_xlat8;
ivec2 u_xlati8;
bvec2 u_xlatb8;
float u_xlat12;
bool u_xlatb12;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb4 = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat8.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat12 = _Time.y * _BaseTex_Vspeed + u_xlat8.y;
    u_xlat8.x = _Time.y * _BaseTex_Uspeed + u_xlat8.x;
    u_xlat1.x = u_xlat12 + vs_TEXCOORD1.y;
    u_xlat1.y = (u_xlatb4) ? u_xlat1.x : u_xlat12;
    u_xlat4 = u_xlat8.x + vs_TEXCOORD1.x;
    u_xlatb2 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat1.x = (u_xlatb2.x) ? u_xlat4 : u_xlat8.x;
    u_xlat1 = texture(_BaseTex, u_xlat1.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat4 = u_xlat0.x * _BaseTexAlphaBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb8.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat12 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat5 = u_xlat12 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb8.x) ? u_xlat5 : u_xlat12;
    u_xlat8.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb12 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb12) ? u_xlat8.x : u_xlat1.x;
    u_xlat1 = texture(_MaskTex, u_xlat2.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat8.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat8.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat8.x;
    u_xlat8.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat8.x;
    u_xlat8.x = u_xlat8.x * _MaskTexBrightness;
    u_xlat4 = u_xlat8.x * u_xlat4;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat8.x;
    u_xlatb8.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb8.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb8.x) ? u_xlat4 : u_xlat0.x;
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat4 = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati4]._MeshParticleColorArray.w;
    u_xlat8.x = _DayColor.w * _AlphaBrightness;
    u_xlat4 = u_xlat4 * u_xlat8.x;
    u_xlat4 = u_xlat4 * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat4;
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
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
int u_xlati4;
void main()
{
    u_xlat0.x = _MotionVectorDepthBias * 2.0 + _MHYZBias;
    u_xlati4 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati4 = u_xlati4 << 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
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
    u_xlat0.xzw = in_POSITION0.yyy * unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xyz;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xyz * in_POSITION0.xxx + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xyz * in_POSITION0.zzz + u_xlat0.xzw;
    u_xlat0.xzw = unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz * in_POSITION0.www + u_xlat0.xzw;
    u_xlat0.xzw = (-u_xlat0.xzw) + _WorldSpaceCameraPos.xyz;
    u_xlat3.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    vs_TEXCOORD5.xyz = u_xlat0.xzw * u_xlat3.xxx;
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    vs_TEXCOORD5.w = (-u_xlat0.x);
    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD6.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD6.w = 0.0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.zw = u_xlat2.zw;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	float _AlphaBrightness;
uniform 	vec4 _MainColor;
uniform 	mediump float _BaseTexAlphaChannelSwitch;
uniform 	mediump float _BaseTexURandomToggle;
uniform 	float _BaseTex_Uspeed;
uniform 	vec4 _BaseTex_ST;
uniform 	mediump float _BaseTexVRandomToggle;
uniform 	float _BaseTex_Vspeed;
uniform 	float _Noise_Brightness;
uniform 	mediump float _NoiseTexChannelSwitch;
uniform 	mediump float _NoiseTexUVRandomToggle;
uniform 	float _NoiseTex_Uspeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseTex_Vspeed;
uniform 	float _Noise_Offset;
uniform 	mediump float _BaseTexAlphaBrightness;
uniform 	mediump float _MaskTexBlendModeToggle;
uniform 	mediump float _MaskTexBrightness;
uniform 	mediump float _MaskTexChannelSwitch;
uniform 	mediump float _NoiseIntensityOnMask;
uniform 	mediump float _MaskTexURandomToggle;
uniform 	float _MaskTex_Uspeed;
uniform 	vec4 _MaskTex_ST;
uniform 	mediump float _MaskTexVRandomToggle;
uniform 	float _MaskTex_Vspeed;
struct miHoYoTemplateParticleParticleWithoutNormalArray_Type {
	mediump vec4 _MeshParticleColorArray;
};
layout(std140) uniform UnityInstancing_miHoYoTemplateParticleParticleWithoutNormal {
	miHoYoTemplateParticleParticleWithoutNormalArray_Type miHoYoTemplateParticleParticleWithoutNormalArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
};
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _BaseTex;
uniform lowp sampler2D _MaskTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
flat in highp uint vs_SV_InstanceID0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
bvec4 u_xlatb2;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
vec2 u_xlat5;
int u_xlati5;
float u_xlat6;
vec2 u_xlat10;
ivec2 u_xlati10;
bvec2 u_xlatb10;
float u_xlat15;
bool u_xlatb15;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_NoiseTexChannelSwitch==3.0);
#else
    u_xlatb0 = _NoiseTexChannelSwitch==3.0;
#endif
    u_xlat5.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.x = _Time.y * _NoiseTex_Uspeed + u_xlat5.x;
    u_xlat1.y = _Time.y * _NoiseTex_Vspeed + u_xlat5.y;
    u_xlat5.xy = u_xlat1.xy + vs_TEXCOORD1.xy;
    u_xlatb2 = equal(vec4(_NoiseTexUVRandomToggle, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch, _NoiseTexChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat5.xy = (u_xlatb2.x) ? u_xlat5.xy : u_xlat1.xy;
    u_xlat1 = texture(_NoiseTex, u_xlat5.xy);
    u_xlat0.x = u_xlatb0 ? u_xlat1.w : float(0.0);
    u_xlat0.x = (u_xlatb2.w) ? u_xlat1.z : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.z) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb2.y) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + _Noise_Offset;
    u_xlat5.x = u_xlat0.x * _Noise_Brightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_MaskTexURandomToggle==1.0);
#else
    u_xlatb10.x = _MaskTexURandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat15 = _Time.y * _MaskTex_Uspeed + u_xlat1.x;
    u_xlat1.x = _Time.y * _MaskTex_Vspeed + u_xlat1.y;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.x;
    u_xlat2.x = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_MaskTexVRandomToggle==1.0);
#else
    u_xlatb15 = _MaskTexVRandomToggle==1.0;
#endif
    u_xlat2.y = (u_xlatb15) ? u_xlat10.x : u_xlat1.x;
    u_xlat5.xy = u_xlat5.xx * vec2(_NoiseIntensityOnMask) + u_xlat2.xy;
    u_xlat1 = texture(_MaskTex, u_xlat5.xy);
    u_xlatb2 = equal(vec4(vec4(_MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch, _MaskTexChannelSwitch)), vec4(0.0, 1.0, 2.0, 3.0));
    u_xlat5.x = u_xlatb2.w ? u_xlat1.w : float(0.0);
    u_xlat5.x = (u_xlatb2.z) ? u_xlat1.z : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.y) ? u_xlat1.y : u_xlat5.x;
    u_xlat5.x = (u_xlatb2.x) ? u_xlat1.x : u_xlat5.x;
    u_xlat5.x = u_xlat5.x * _MaskTexBrightness;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10.x = !!(_BaseTexVRandomToggle==1.0);
#else
    u_xlatb10.x = _BaseTexVRandomToggle==1.0;
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _BaseTex_ST.xy + _BaseTex_ST.zw;
    u_xlat15 = _Time.y * _BaseTex_Vspeed + u_xlat1.y;
    u_xlat1.x = _Time.y * _BaseTex_Uspeed + u_xlat1.x;
    u_xlat6 = u_xlat15 + vs_TEXCOORD1.y;
    u_xlat2.y = (u_xlatb10.x) ? u_xlat6 : u_xlat15;
    u_xlat10.x = u_xlat1.x + vs_TEXCOORD1.x;
    u_xlatb3 = equal(vec4(_BaseTexURandomToggle, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch, _BaseTexAlphaChannelSwitch), vec4(1.0, 0.0, 1.0, 2.0));
    u_xlat2.x = (u_xlatb3.x) ? u_xlat10.x : u_xlat1.x;
    u_xlat0.xz = vec2(vec2(_Noise_Brightness, _Noise_Brightness)) * u_xlat0.xx + u_xlat2.xy;
    u_xlat1 = texture(_BaseTex, u_xlat0.xz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_BaseTexAlphaChannelSwitch==3.0);
#else
    u_xlatb0 = _BaseTexAlphaChannelSwitch==3.0;
#endif
    u_xlat0.x = u_xlatb0 ? u_xlat1.z : float(0.0);
    u_xlat0.x = (u_xlatb3.w) ? u_xlat1.y : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.z) ? u_xlat1.x : u_xlat0.x;
    u_xlat0.x = (u_xlatb3.y) ? u_xlat1.w : u_xlat0.x;
    u_xlat10.x = u_xlat0.x * _BaseTexAlphaBrightness;
    u_xlat0.x = u_xlat0.x * _BaseTexAlphaBrightness + u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlatb10.xy = equal(vec4(vec4(_MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle, _MaskTexBlendModeToggle)), vec4(0.0, 1.0, 0.0, 1.0)).xy;
    u_xlat0.x = u_xlatb10.y ? u_xlat0.x : float(0.0);
    u_xlat0.x = (u_xlatb10.x) ? u_xlat5.x : u_xlat0.x;
    u_xlati5 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.x = vs_COLOR0.w * miHoYoTemplateParticleParticleWithoutNormalArray[u_xlati5]._MeshParticleColorArray.w;
    u_xlat10.x = _DayColor.w * _AlphaBrightness;
    u_xlat5.x = u_xlat5.x * u_xlat10.x;
    u_xlat5.x = u_xlat5.x * _MainColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat0.x + (-_MotionVectorsAlphaCutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4<0.0);
#else
    u_xlatb0 = u_xlat16_4<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
    u_xlat0.xy = u_xlat0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat10.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10.xy = u_xlat10.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat10.xy * vec2(0.5, 0.5) + (-u_xlat0.xy);
    u_xlati10.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat0.xy = sqrt(abs(u_xlat0.xy));
    u_xlati10.xy = (-u_xlati10.xy) + u_xlati1.xy;
    u_xlat10.xy = vec2(u_xlati10.xy);
    u_xlat0.xy = u_xlat10.xy * u_xlat0.xy;
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
Keywords { "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
SubProgram "gles3 " {
Keywords { "INSTANCING_ON" "HALF_RESOLUTION_PARTICLE_ON" "_NOISETEXTOGGLE_ON" "_MASKTEXTOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}